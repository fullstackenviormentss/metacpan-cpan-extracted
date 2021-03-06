/* -*- Mode: c; c-basic-offset: 2 -*-
 *
 * rasqal_graph_pattern.c - Rasqal graph pattern class
 *
 * $Id: rasqal_graph_pattern.c 11551 2006-10-29 21:12:27Z dajobe $
 *
 * Copyright (C) 2004-2006, David Beckett http://purl.org/net/dajobe/
 * Copyright (C) 2004-2005, University of Bristol, UK http://www.bristol.ac.uk/
 * 
 * This package is Free Software and part of Redland http://librdf.org/
 * 
 * It is licensed under the following three licenses as alternatives:
 *   1. GNU Lesser General Public License (LGPL) V2.1 or any newer version
 *   2. GNU General Public License (GPL) V2 or any newer version
 *   3. Apache License, V2.0 or any newer version
 * 
 * You may not use this file except in compliance with at least one of
 * the above three licenses.
 * 
 * See LICENSE.html or LICENSE.txt at the top of this package for the
 * complete terms and further detail along with the license texts for
 * the licenses in COPYING.LIB, COPYING and LICENSE-2.0.txt respectively.
 * 
 * 
 */

#ifdef HAVE_CONFIG_H
#include <rasqal_config.h>
#endif

#ifdef WIN32
#include <win32_rasqal_config.h>
#endif

#include <stdio.h>
#include <string.h>
#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif
#include <stdarg.h>

#include "rasqal.h"
#include "rasqal_internal.h"


/**
 * rasqal_new_graph_pattern:
 * @query: #rasqal_graph_pattern query object
 *
 * Create a new graph pattern object.
 * 
 * Return value: a new #rasqal_graph_pattern object or NULL on failure
 **/
rasqal_graph_pattern*
rasqal_new_graph_pattern(rasqal_query* query) {
  rasqal_graph_pattern* gp=(rasqal_graph_pattern*)RASQAL_CALLOC(rasqal_graph_pattern, 1, sizeof(rasqal_graph_pattern));

  if(!query)
    return NULL;
  
  gp->query=query;

  gp->start_column= -1;
  gp->end_column= -1;

  /* This is initialised by rasqal_query_prepare_count_graph_patterns() inside
   * rasqal_query_prepare()
   */
  gp->gp_index= -1;

  return gp;
}


/**
 * rasqal_new_graph_pattern_from_triples:
 * @query: #rasqal_graph_pattern query object
 * @triples: triples sequence containing the graph pattern
 * @start_column: first triple in the pattern
 * @end_column: last triple in the pattern
 * @op: enum #rasqal_graph_pattern_operator operator
 *
 * Create a new graph pattern object over triples.
 * 
 * Return value: a new #rasqal_graph_pattern object or NULL on failure
 **/
rasqal_graph_pattern*
rasqal_new_graph_pattern_from_triples(rasqal_query* query,
                                      raptor_sequence *triples,
                                      int start_column, int end_column,
                                      rasqal_graph_pattern_operator op)
{
  rasqal_graph_pattern* gp;

  if(!triples)
    return NULL;
  
  gp=rasqal_new_graph_pattern(query);
  if(!gp)
    return NULL;

  rasqal_graph_pattern_add_triples(gp, 
                                   triples, start_column, end_column, op);
  return gp;
}


/**
 * rasqal_new_graph_pattern_from_sequence:
 * @query: #rasqal_graph_pattern query object
 * @graph_patterns: sequence containing the graph patterns
 * @operator: enum #rasqal_graph_pattern_operator such as
 * RASQAL_GRAPH_PATTERN_OPERATOR_OPTIONAL
 *
 * Create a new graph pattern from a sequence of graph_patterns.
 * 
 * Return value: a new #rasqal_graph_pattern object or NULL on failure
 **/
rasqal_graph_pattern*
rasqal_new_graph_pattern_from_sequence(rasqal_query* query,
                                       raptor_sequence *graph_patterns, 
                                       rasqal_graph_pattern_operator op)
{
  rasqal_graph_pattern* gp;

  gp=rasqal_new_graph_pattern(query);
  if(!gp)
    return NULL;
  
  gp->graph_patterns=graph_patterns;
  gp->op=op;

  gp->finished=0;

  return gp;
}


/**
 * rasqal_graph_pattern_add_triples:
 * @graph_pattern: #rasqal_graph_pattern object
 * @triples: triples sequence containing the graph pattern
 * @start_column: first triple in the pattern
 * @end_column: last triple in the pattern
 * @operator: enum #rasqal_graph_pattern_operator such as 
 *   RASQAL_GRAPH_PATTERN_OPERATOR_OPTIONAL
 *
 * Add triples to a graph pattern object.
 * 
 * Return value: a new #rasqal_graph_pattern object or NULL on failure
 **/
void
rasqal_graph_pattern_add_triples(rasqal_graph_pattern* gp,
                                 raptor_sequence* triples,
                                 int start_column, int end_column,
                                 rasqal_graph_pattern_operator op)
{
  gp->triples=triples;
  gp->start_column=start_column;
  gp->end_column=end_column;
  gp->finished=0;
  gp->op=op;
}


/**
 * rasqal_free_graph_pattern:
 * @gp: #rasqal_graph_pattern object
 *
 * Free a graph pattern object.
 * 
 **/
void
rasqal_free_graph_pattern(rasqal_graph_pattern* gp)
{
  if(gp->graph_patterns)
    raptor_free_sequence(gp->graph_patterns);
  
  if(gp->constraints_expression)
    rasqal_free_expression(gp->constraints_expression);

  if(gp->constraints)
    raptor_free_sequence(gp->constraints);

  RASQAL_FREE(rasqal_graph_pattern, gp);
}


/**
 * rasqal_graph_pattern_adjust:
 * @gp: #rasqal_graph_pattern graph pattern
 * @offset: adjustment
 *
 * Adjust the column in a graph pattern by the offset.
 * 
 **/
void
rasqal_graph_pattern_adjust(rasqal_graph_pattern* gp, int offset)
{
  gp->start_column += offset;
  gp->end_column += offset;
}


/**
 * rasqal_graph_pattern_add_constraint:
 * @gp: #rasqal_graph_pattern query object
 * @expr: #rasqal_expression expr
 *
 * Add a constraint expression to the graph_pattern.
 *
 * Return value: non-0 on failure
 **/
int
rasqal_graph_pattern_add_constraint(rasqal_graph_pattern* gp,
                                    rasqal_expression* expr)
{
  if(!gp->constraints)
    gp->constraints=raptor_new_sequence((raptor_sequence_free_handler*)rasqal_free_expression, (raptor_sequence_print_handler*)rasqal_expression_print);
  raptor_sequence_push(gp->constraints, (void*)expr);

  return 0;
}


/**
 * rasqal_graph_pattern_get_constraint_sequence:
 * @gp: #rasqal_graph_pattern object
 *
 * Get the sequence of constraints expressions in the query.
 *
 * Return value: a #raptor_sequence of #rasqal_expression pointers.
 **/
raptor_sequence*
rasqal_graph_pattern_get_constraint_sequence(rasqal_graph_pattern* gp)
{
  return gp->constraints;
}


/**
 * rasqal_graph_pattern_get_constraint:
 * @gp: #rasqal_graph_pattern query object
 * @idx: index into the sequence (0 or larger)
 *
 * Get a constraint in the sequence of constraint expressions in the query.
 *
 * Return value: a #rasqal_expression pointer or NULL if out of the sequence range
 **/
rasqal_expression*
rasqal_graph_pattern_get_constraint(rasqal_graph_pattern* gp, int idx)
{
  if(!gp->constraints)
    return NULL;

  return (rasqal_expression*)raptor_sequence_get_at(gp->constraints, idx);
}


/**
 * rasqal_graph_pattern_get_operator:
 * @graph_pattern: #rasqal_graph_pattern graph pattern object
 *
 * Get the graph pattern operator .
 * 
 * The operator for the given graph pattern. See also
 * rasqal_graph_pattern_operator_as_string().
 *
 * Return value: graph pattern operator
 **/
rasqal_graph_pattern_operator
rasqal_graph_pattern_get_operator(rasqal_graph_pattern* graph_pattern)
{
  return graph_pattern->op;
}


static const char* rasqal_graph_pattern_operator_labels[RASQAL_GRAPH_PATTERN_OPERATOR_LAST+1]={
  "UNKNOWN",
  "basic",
  "optional",
  "union",
  "group",
  "graph"
};


/**
 * rasqal_graph_pattern_operator_as_string:
 * @op: the #rasqal_graph_pattern_operator verb of the query
 *
 * Get a string for the query verb.
 * 
 * Return value: pointer to a shared string label for the query verb
 **/
const char*
rasqal_graph_pattern_operator_as_string(rasqal_graph_pattern_operator op)
{
  if(op <= RASQAL_GRAPH_PATTERN_OPERATOR_UNKNOWN || 
     op > RASQAL_GRAPH_PATTERN_OPERATOR_LAST)
    op=RASQAL_GRAPH_PATTERN_OPERATOR_UNKNOWN;

  return rasqal_graph_pattern_operator_labels[(int)op];
}
  

/**
 * rasqal_graph_pattern_print:
 * @gp: the #rasqal_graph_pattern object
 * @fh: the #FILE* handle to print to
 *
 * Print a #rasqal_graph_pattern in a debug format.
 * 
 * The print debug format may change in any release.
 * 
 **/
void
rasqal_graph_pattern_print(rasqal_graph_pattern* gp, FILE* fh)
{
  fputs("graph pattern", fh);
  if(gp->gp_index >= 0)
    fprintf(fh, "[%d]", gp->gp_index);
  fprintf(fh, " %s(", rasqal_graph_pattern_operator_as_string(gp->op));
  if(gp->triples) {
    int size=gp->end_column - gp->start_column +1;
    int i;
    if(size != 1)
      fprintf(fh, "over %d triples[", size);
    else
      fputs("over 1 triple[", fh);

    for(i=gp->start_column; i <= gp->end_column; i++) {
      rasqal_triple *t=(rasqal_triple*)raptor_sequence_get_at(gp->triples, i);
      rasqal_triple_print(t, fh);
      if(i < gp->end_column)
        fputs(", ", fh);
    }
    fputs("]", fh);
  }
  if(gp->graph_patterns) {
    int size=raptor_sequence_size(gp->graph_patterns);
    if(size !=1)
      fprintf(fh, "over %d graph_patterns", size);
    else
      fputs("over 1 graph_pattern", fh);
    raptor_sequence_print(gp->graph_patterns, fh);
  }
  if(gp->constraints) {
    fprintf(fh, " with constraints: ");
    raptor_sequence_print(gp->constraints, fh);
  }
  fputs(")", fh);
}


/**
 * rasqal_graph_pattern_visit:
 * @query: #rasqal_query to operate on
 * @gp: #rasqal_graph_pattern graph pattern
 * @fn: pointer to function to apply that takes user data and graph pattern parameters
 * @user_data: user data for applied function 
 * 
 * Visit a user function over a #rasqal_graph_pattern
 *
 * If the user function @fn returns 0, the visit is truncated.
 *
 * Return value: 0 if the visit was truncated.
 **/
int
rasqal_graph_pattern_visit(rasqal_query *query,
                           rasqal_graph_pattern* gp,
                           rasqal_graph_pattern_visit_fn fn,
                           void *user_data)
{
  raptor_sequence *seq;
  int result;
  
  result=fn(query, gp, user_data);
  if(result)
    return result;
  
  seq=rasqal_graph_pattern_get_sub_graph_pattern_sequence(gp);
  if(seq && raptor_sequence_size(seq) > 0) {
    int gp_index=0;
    while(1) {
      rasqal_graph_pattern* sgp;
      sgp=rasqal_graph_pattern_get_sub_graph_pattern(gp, gp_index);
      if(!sgp)
        break;
      
      result=rasqal_graph_pattern_visit(query, sgp, fn, user_data);
      if(result)
        return result;
      gp_index++;
    }
  }

  return 0;
}


/**
 * rasqal_graph_pattern_get_index:
 * @gp: #rasqal_graph_pattern graph pattern
 * 
 * Get the graph pattern absolute index in the array of graph patterns.
 * 
 * The graph pattern index is assigned when rasqal_query_prepare() is
 * run on a query containing a graph pattern.
 *
 * Return value: index or <0 if no index has been assigned yet
 **/
int
rasqal_graph_pattern_get_index(rasqal_graph_pattern* gp)
{
  return gp->gp_index;
}

