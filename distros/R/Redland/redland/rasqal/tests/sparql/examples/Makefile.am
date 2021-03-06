# -*- Mode: Makefile -*-
#
# Makefile.am - automake file for Rasqal SPARQL tests
#
# $Id: Makefile.am 5437 2006-01-23 03:28:53Z dajobe $
#
# Copyright (C) 2004-2006, David Beckett http://purl.org/net/dajobe/
# Copyright (C) 2004-2005, University of Bristol, UK http://www.bristol.ac.uk/
# 
# This package is Free Software and part of Redland http://librdf.org/
# 
# It is licensed under the following three licenses as alternatives:
#   1. GNU Lesser General Public License (LGPL) V2.1 or any newer version
#   2. GNU General Public License (GPL) V2 or any newer version
#   3. Apache License, V2.0 or any newer version
# 
# You may not use this file except in compliance with at least one of
# the above three licenses.
# 
# See LICENSE.html or LICENSE.txt at the top of this package for the
# complete terms and further detail along with the license texts for
# the licenses in COPYING.LIB, COPYING and LICENSE-2.0.txt respectively.
# 

SPARQL_MANIFEST_FILES= manifest.n3

SPARQL_MODEL_FILES= \
ex2-1a.n3 ex2-1d.n3 ex2-1f.n3 ex2-2a.n3 ex2-3a.n3 ex2-4a.n3 ex3.n3	\
ex11.2.3.1_0.n3 ex11.2.3.1_1.n3 ex11.2.3.2_0.n3 ex11.2.3.3_0.n3		\
ex11.2.3.4_0.n3 ex11.2.3.5_0.n3 ex11.2.3.6_0.n3 ex11.2.3.7_0.n3		\
ex11.2.3.8_0.n3 ex11_0.n3

SPARQL_TEST_FILES= \
ex2-1a.rq ex2-1b.rq ex2-1c.rq ex2-1e.rq ex2-2a.rq ex2-3a.rq ex2-4a.rq	\
ex3.rq ex11.2.3.1_0.rq ex11.2.3.1_1.rq ex11.2.3.2_0.rq			\
ex11.2.3.2_1.rq ex11.2.3.3_0.rq ex11.2.3.4_0.rq ex11.2.3.5_0.rq		\
ex11.2.3.6_0.rq ex11.2.3.7_0.rq ex11.2.3.8_0.rq ex11_0.rq ex11_1.rq

# sparql-query-example-Testing-Values-0 (ex11_0.rq)
#   FILTER dateTime datatype compare
# sparql-query-example-Testing-Values-RDFterm-equal-2 (ex11.2.3.1_1.rq)
#   FILTER dateTime datatype equality
# sparql-query-example-Testing-Values-bound (ex11.2.3.2_0.rq)
#   FILTER bound and dateTime datatype compare

EXPECTED_SPARQL_CORRECT_FAILURES= \
sparql-query-example-e			\
sparql-query-example-Testing-Values-0			\
sparql-query-example-Testing-Values-RDFterm-equal-2	\
sparql-query-example-Testing-Values-bound



SPARQL_RESULT_FILES= \
ex2-1a-result.n3 ex2-2a-result.n3 ex2-3a-result.n3 ex2-4a-result.n3	\
ex3-result.n3 ex11.2.3.1_0-result.n3 ex11.2.3.1_1-result.n3		\
ex11.2.3.2_0-result.n3 ex11.2.3.2_1-result.n3 ex11.2.3.3_0-result.n3	\
ex11.2.3.4_0-result.n3 ex11.2.3.5_0-result.n3 ex11.2.3.6_0-result.n3	\
ex11.2.3.7_0-result.n3 ex11.2.3.8_0-result.n3 ex11_0-result.n3		\
ex11_1-result.n3


EXTRA_DIST= \
$(SPARQL_MANIFEST_FILES) \
$(SPARQL_MODEL_FILES) \
$(SPARQL_TEST_FILES) \
$(SPARQL_RESULT_FILES)

build-roqet:
	@(cd $(top_builddir)/utils ; $(MAKE) roqet)

build-sparql-lexer-test:
	@(cd $(top_builddir)/src ; $(MAKE) sparql_lexer_test)

build-sparql-parser-test:
	@(cd $(top_builddir)/src ; $(MAKE) sparql_parser_test)


check-local: check-sparql-lexer check-sparql-parser \
check-sparql-correct

check-sparql-lexer: build-sparql-lexer-test
	@set +e; result=0; \
	$(ECHO) "Testing legal SPARQL lexing"; \
	for test in $(SPARQL_TEST_FILES); do \
	  $(ECHO) $(ECHO_N) "Checking $$test $(ECHO_C)"; \
	  $(top_builddir)/src/sparql_lexer_test $(srcdir)/$$test >/dev/null; \
	  status=$$?; \
	  if test $$status != 0 -a $$status != 2 ; then \
	    $(ECHO) FAILED returned status $$status; result=1; \
	  else \
	    $(ECHO) ok; \
	  fi; \
	done; \
	set -e; exit $$result

check-sparql-parser: build-sparql-parser-test
	@set +e; result=0; \
	$(ECHO) "Testing legal SPARQL parsing"; \
	for test in $(SPARQL_TEST_FILES); do \
	  $(ECHO) $(ECHO_N) "Checking $$test $(ECHO_C)"; \
	  $(top_builddir)/src/sparql_parser_test $(srcdir)/$$test >/dev/null; \
	  status=$$?; \
	  if test $$status != 0 -a $$status != 2 ; then \
	    $(ECHO) FAILED returned status $$status; result=1; \
	    fails="$$fails $$test"; \
	  else \
	    $(ECHO) ok; \
	  fi; \
	done; \
	set -e; exit $$result

check-sparql-correct: build-roqet $(srcdir)/../check-sparql
	@set +e; \
	expect=`echo $(EXPECTED_SPARQL_CORRECT_FAILURES) | wc -w`; \
	$(ECHO) "Testing SPARQL correct"; \
	PATH=$(top_builddir)/utils:$(top_builddir)@RAPPER_PATH@:$$PATH \
	  perl $(srcdir)/../check-sparql -s $(srcdir); \
	result=$$?; \
	if test $$result != 0 ; then \
	  echo "Expecting test failures: $(EXPECTED_SPARQL_CORRECT_FAILURES)"; \
	  if test $$result = $$expect ; then \
	    echo "OK: Ignoring $$expect expected test failures"; result=0; \
          else \
	    echo "FAILED: $$result failures does not match expected $$expect"; result=1; \
          fi; \
	fi; \
	set -e; exit $$result
