#include "config.h"

#if defined HAS_QUAD
typedef Quad_t align_t;
#else
typedef long align_t;
#endif

#ifdef I_STDARG
#  include <stdarg.h>
#else
#  ifdef I_VARARGS
#    include <varargs.h>
#  endif
#endif

/* try to find a working va_copy macro */
#ifndef va_copy
#  ifdef __va_copy
#    define va_copy __va_copy
#  else
#    define va_copy(to,from)	((to)=(from))
#  endif
#endif

#include <sys/types.h>

#if defined(I_STRING) || defined(__cplusplus)
#   include <string.h>
#else
#   include <strings.h>
#endif

/* datatypes */

/* braindamaged IBM header files #define true and false */
#undef FALSE
#undef TRUE
#undef bool
#undef yyerror
#undef YYSTYPE

extern int interactive;

typedef void builtin_t(char **);
typedef struct Block Block;
typedef struct Dup Dup;
typedef struct Estack Estack;
typedef struct Function Function;
typedef struct Hq Hq;
typedef struct Htab Htab;
typedef struct Jbwrap Jbwrap;
typedef struct List List;
typedef struct Node Node;
typedef struct Pipe Pipe;
typedef struct Redir Redir;
typedef struct Rq Rq;
typedef struct Variable Variable;
typedef struct Word Word;
typedef struct Format Format;
typedef union Edata Edata;

typedef enum nodetype {
	nAndalso, nAssign, nBackq, nBang, nBody, nCbody, nNowait, nBrace, nConcat,
	nCount, nElse, nFlat, nDup, nEpilog, nNewfn, nForin, nIf, nQword,
	nOrelse, nPipe, nPre, nRedir, nRmfn, nArgs, nSubshell, nCase,
	nSwitch, nMatch, nVar, nVarsub, nWhile, nWord, nLappend, nNmpipe
} nodetype;

typedef enum ecodes {
	eError, eBreak, eReturn, eVarstack, eArena, eFifo, eFd
} ecodes;

typedef enum bool {
	FALSE, TRUE
} bool;

typedef enum inputtype {
	iFd, iString
} inputtype;

typedef enum redirtype {
	rFrom, rCreate, rAppend, rHeredoc, rHerestring
} redirtype;

typedef bool (*Conv)(Format *, int);

union Edata {
	Jbwrap *jb;
	Block *b;
	char *name;
	int fd;
};

struct Estack {
	ecodes e;
	bool interactive;
	Edata data;
	Estack *prev;
};

struct List {
	char *w, *m;
	List *n;
};

struct Node {
	nodetype type;
	union {
		char *s;
		int i;
		Node *p;
	} u[4];
};

struct Pipe {
	int left, right;
};

struct Dup {
	redirtype type;
	int left, right;
};

struct Redir {
	redirtype type;
	int fd;
};

struct Word {
	char *w, *m;
};

struct Rq {
	Node *r;
	struct Rq *n;
};

struct Function {
	Node *def;
	char *extdef;
};

struct Variable {
	List *def;
	char *extdef;
	Variable *n;
};

struct Htab {
	char *name;
	void *p;
};

struct Format {
	/* for the formatting routines */
	va_list args;
	long flags, f1, f2;
	/* for the buffer maintainence routines */
	char *buf, *bufbegin, *bufend;
	int flushed;
	void (*grow)(Format *, size_t);
	union { int n; void *p; } u;
};

/* Format->flags values */
enum {
	FMT_quad	= 1,		/* %q */
	FMT_long	= 2,		/* %l */
	FMT_short	= 4,		/* %h */
	FMT_unsigned	= 8,		/* %u */
	FMT_zeropad	= 16,		/* %0 */
	FMT_leftside	= 32,		/* %- */
	FMT_altform	= 64,		/* %# */
	FMT_f1set	= 128,		/* %<n> */
	FMT_f2set	= 256		/* %.<n> */
};

/* macros */
#define EOF (-1)

#ifndef NULL
#define NULL 0
#endif

#define a2u(x) n2u(x, 10)
#define o2u(x) n2u(x, 8)
#define arraysize(a) ((int)(sizeof(a)/sizeof(*a)))
#define enew(x) ((x *) ealloc(sizeof(x)))
#define ecpy(x) strcpy((char *) ealloc(strlen(x) + 1), x)
#define lookup_fn(s) ((Function *) lookup(s, fp))
#define lookup_var(s) ((Variable *) lookup(s, vp))
#define nnew(x) ((x *) nalloc(sizeof(x)))
#define ncpy(x) (strcpy((char *) nalloc(strlen(x) + 1), x))

#ifndef offsetof
#define offsetof(t, m) ((size_t) (((char *) &((t *) 0)->m) - (char *)0))
#endif

#define streq(x, y) (*(x) == *(y) && strcmp(x, y) == 0)
#define conststrlen(x) (sizeof (x) - 1)

/* rc prototypes */

/* main.c */
extern char *prompt, *prompt2;
extern int lineno;

/* footobar.c */
extern char **list2array(List *, bool);
extern char *get_name(char *);
extern List *parse_var(char *, char *);
extern Node *parse_fn(char *, char *);
extern void initprint(void);
extern void rc_exit(int); /* here for odd reasons; user-defined signal handlers are kept in fn.c */

/* hash.c */
extern Htab *fp, *vp;
extern void *lookup(char *, Htab *);
extern Function *get_fn_place(char *);
extern List *varlookup(char *);
extern Node *fnlookup(char *);
extern Variable *get_var_place(char *, bool);
extern bool varassign_string(char *);
extern char **makeenv(void);
extern char *fnlookup_string(char *);
extern char *varlookup_string(char *);
extern void alias(char *, List *, bool);
extern void starassign(char *, char **, bool);
extern void delete_fn(char *);
extern void delete_var(char *, bool);
extern void fnassign(char *, Node *);
extern void fnassign_string(char *);
extern void fnrm(char *);
extern void initenv(char **);
extern void inithash(void);
extern void setsigdefaults(bool);
extern void inithandler(void);
extern void varassign(char *, List *, bool);
extern void varrm(char *, bool);
extern void whatare_all_vars(bool, bool);
extern void whatare_all_signals(void);
extern void prettyprint_var(int, char *, List *);
extern void prettyprint_fn(int, char *, Node *);

/* heredoc.c */
extern int heredoc(int);
extern int qdoc(Node *, Node *);
extern Hq *hq;

/* input.c */
extern void initinput(void);
extern Node *parseline(char *extdef, int len);
extern int gchar(void);
extern void ugchar(int);
extern Node *doit();
extern void flushu(void);
extern void pushfd(int);
extern void popinput(void);
extern void closefds(void);
extern int last;

/* lex.c */
extern int yylex(void);
extern void inityy(void);
extern void yyerror(const char *);
extern void scanerror(char *);
extern void print_prompt2(void);
extern const char nw[], dnw[];

/* list.c */
extern void listfree(List *);
extern List *listcpy(List *, void *(*)(size_t));
extern size_t listlen(List *);
extern int listnel(List *);

/* match.c */
extern bool match(char *, char *, char *);

/* alloc.c */
extern void *ealloc(size_t);
extern void *erealloc(void *, size_t);
extern void efree(void *);
extern Block *newblock(void);
extern void *nalloc(size_t);
extern void nfree(void);
extern void restoreblock(Block *);

/* open.c */
extern int rc_open(const char *, redirtype);

/* print.c */
/*
   The following prototype should be:
extern Conv fmtinstall(int, Conv);
   but this freaks out SGI's compiler under IRIX3.3.2
*/
extern bool (*fmtinstall(int, bool (*)(Format *, int)))(Format *, int);
extern int printfmt(Format *, const char *);
extern int fmtprint(Format *, const char *,...);
extern void fmtappend(Format *, const char *, size_t);
extern void fmtcat(Format *, const char *);
extern int fprint(int fd, const char *fmt,...);
extern char *mprint(const char *fmt,...);
extern char *nprint(const char *fmt,...);
/*
   the following macro should by rights be coded as an expression, not
   a statement, but certain compilers (notably DEC) have trouble with
   void expressions inside the ?: operator. (sheesh, give me a break!)
*/
#define	fmtputc(f, c) {\
	if ((f)->buf >= (f)->bufend)\
		(*(f)->grow)((f), (size_t)1);\
	*(f)->buf++ = (c);\
}

/* y.tab.c (parse.y) */
extern Node *parsetree;
extern int yyparse(void);
extern void initparse(void);

/* tree.c */
extern Node *mk(int /*nodetype*/,...);
extern Node *treecpy(Node *, void *(*)(size_t));
extern void treefree(Node *);

/* utils.c */
extern bool isabsolute(char *);
extern int n2u(char *, unsigned int);
extern int rc_read(int, char *, size_t);
extern int mvfd(int, int);
extern int starstrcmp(const void *, const void *);
extern void pr_error(char *);
extern void panic(char *);
extern void uerror(char *);
extern void writeall(int, char *, size_t);

void	Perl_warn(const char* pat,...);
#define warn Perl_warn
#define panic Perl_croak

extern void walk(Node *nd);
