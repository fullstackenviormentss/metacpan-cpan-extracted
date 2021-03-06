/* Copyright © International Business Machines Corp., 2006
 *              Adelard LLP, 2007
 *
 * Author: Josh Triplett <josh@freedesktop.org>
 *         Dan Sheridan <djs@adelard.com>
 *
 * Licensed under the Open Software License version 1.1
 */
#include <stdarg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <fcntl.h>

#include "lib.h"
#include "allocate.h"
#include "token.h"
#include "parse.h"
#include "symbol.h"
#include "expression.h"
#include "linearize.h"


/* Draw the subgraph for a given entrypoint. Includes details of loads
 * and stores for globals, and marks return bbs */
static void graph_ep(SCTX_ struct entrypoint *ep)
{
	struct basic_block *bb;
	struct instruction *insn;

	const char *fname, *sname;

	fname = show_ident(sctx_ ep->name->ident);
	sname = stream_name(sctx_ ep->entry->bb->pos->pos.stream);

	printf("subgraph cluster%p {\n"
	       "    color=blue;\n"
	       "    label=<<TABLE BORDER=\"0\" CELLBORDER=\"0\">\n"
	       "             <TR><TD>%s</TD></TR>\n"
	       "             <TR><TD><FONT POINT-SIZE=\"21\">%s()</FONT></TD></TR>\n"
	       "           </TABLE>>;\n"
	       "    file=\"%s\";\n"
	       "    fun=\"%s\";\n"
	       "    ep=bb%p;\n",
	       ep, sname, fname, sname, fname, ep->entry->bb);

	FOR_EACH_PTR(ep->bbs, bb) {
		struct basic_block *child;
		int ret = 0;
		const char * s = ", ls=\"[";

		/* Node for the bb */
		printf("    bb%p [shape=ellipse,label=%d,line=%d,col=%d",
		       bb, bb->pos->pos.line, bb->pos->pos.line, bb->pos->pos.pos);


		/* List loads and stores */
		FOR_EACH_PTR(bb->insns, insn) {
			switch(insn->opcode) {
			case OP_STORE:
				if (insn->symbol->type == PSEUDO_SYM) {
				  printf("%s store(%s)", s, show_ident(sctx_ insn->symbol->sym->ident));
				  s = ",";
				}
				break;

			case OP_LOAD:
				if (insn->symbol->type == PSEUDO_SYM) {
				  printf("%s load(%s)", s, show_ident(sctx_ insn->symbol->sym->ident));
				  s = ",";
				}
				break;

			case OP_RET:
				ret = 1;
				break;

			}
		} END_FOR_EACH_PTR(insn);
		if (s[1] == 0)
			printf("]\"");
		if (ret)
			printf(",op=ret");
		printf("];\n");

		/* Edges between bbs; lower weight for upward edges */
		FOR_EACH_PTR(bb->children, child) {
			printf("    bb%p -> bb%p [op=br, %s];\n", bb, child,
			       (bb->pos->pos.line > child->pos->pos.line) ? "weight=5" : "weight=10");
		} END_FOR_EACH_PTR(child);
	} END_FOR_EACH_PTR(bb);

	printf("}\n");
}


/* Insert edges for intra- or inter-file calls, depending on the value
 * of internal. Bold edges are used for calls with destinations;
 * dashed for calls to external functions */
static void graph_calls(SCTX_ struct entrypoint *ep, int internal)
{
	struct basic_block *bb;
	struct instruction *insn;

	show_ident(sctx_ ep->name->ident);
	stream_name(sctx_ ep->entry->bb->pos->pos.stream);

	FOR_EACH_PTR(ep->bbs, bb) {
		if (!bb)
			continue;
		if (!bb->parents && !bb->children && !bb->insns && sctxp verbose < 2)
			continue;

		FOR_EACH_PTR(bb->insns, insn) {
			if (insn->opcode == OP_CALL &&
			    internal == !(insn->func->sym->ctype.modifiers & MOD_EXTERN)) {

				/* Find the symbol for the callee's definition */
				struct symbol * sym;
				if (insn->func->type == PSEUDO_SYM) {
					for (sym = insn->func->sym->ident->symbols;
					     sym; sym = sym->next_id) {
						if (sym->namespace & NS_SYMBOL && sym->ep)
							break;
					}

					if (sym)
						printf("bb%p -> bb%p"
						       "[label=%d,line=%d,col=%d,op=call,style=bold,weight=30];\n",
						       bb, sym->ep->entry->bb,
						       insn->pos.line, insn->pos.line, insn->pos.pos);
					else
						printf("bb%p -> \"%s\" "
						       "[label=%d,line=%d,col=%d,op=extern,style=dashed];\n",
						       bb, show_pseudo(sctx_ insn->func),
						       insn->pos.line, insn->pos.line, insn->pos.pos);
				}
			}
		} END_FOR_EACH_PTR(insn);
	} END_FOR_EACH_PTR(bb);
}

int main(int argc, char **argv)
{
	struct string_list *filelist = NULL;
	char *file;
	struct symbol *sym;
	struct symbol_list *fsyms, *all_syms=NULL;
	SPARSE_CTX_INIT;

	printf("digraph call_graph {\n");
	fsyms = sparse_initialize(sctx_ argc, argv, &filelist);
	concat_symbol_list(sctx_ fsyms, &all_syms);

	/* Linearize all symbols, graph internal basic block
	 * structures and intra-file calls */
	FOR_EACH_PTR_NOTAG(filelist, file) {

		fsyms = sparse(sctx_ file);
		concat_symbol_list(sctx_ fsyms, &all_syms);

		FOR_EACH_PTR(fsyms, sym) {
			expand_symbol(sctx_ sym);
			linearize_symbol(sctx_ sym);
		} END_FOR_EACH_PTR(sym);

		FOR_EACH_PTR(fsyms, sym) {
			if (sym->ep) {
				graph_ep(sctx_ sym->ep);
				graph_calls(sctx_ sym->ep, 1);
			}
		} END_FOR_EACH_PTR_NOTAG(sym);

	} END_FOR_EACH_PTR_NOTAG(file);

	/* Graph inter-file calls */
	FOR_EACH_PTR(all_syms, sym) {
		if (sym->ep)
			graph_calls(sctx_ sym->ep, 0);
	} END_FOR_EACH_PTR_NOTAG(sym);

	printf("}\n");
	return 0;
}
