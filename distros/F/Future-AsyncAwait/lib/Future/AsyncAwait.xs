/*  You may distribute under the terms of either the GNU General Public License
 *  or the Artistic License (the same terms as Perl itself)
 *
 *  (C) Paul Evans, 2016 -- leonerd@leonerd.org.uk
 */

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define HAVE_PERL_VERSION(R, V, S) \
    (PERL_REVISION > (R) || (PERL_REVISION == (R) && (PERL_VERSION > (V) || (PERL_VERSION == (V) && (PERL_SUBVERSION >= (S))))))

#if !HAVE_PERL_VERSION(5, 24, 0)
  /* On perls before 5.24 we have to do some extra work to save the itervar
   * from being thrown away */
#  define HAVE_ITERVAR
#endif

#if HAVE_PERL_VERSION(5, 24, 0)
#  define OLDSAVEIX(cx)  (cx->blk_oldsaveix)
#else
#  define OLDSAVEIX(cx)  (PL_scopestack[cx->blk_oldscopesp-1])
#endif

#ifndef CX_CUR
#  define CX_CUR() (&cxstack[cxstack_ix])
#endif

#ifndef unshare_hek
#  define unshare_hek(a)          Perl_unshare_hek(aTHX_ a)
#endif

#ifdef SAVEt_CLEARPADRANGE
#  include "save_clearpadrange.c.inc"
#endif

#if !HAVE_PERL_VERSION(5, 24, 0)
#  include "cx_pushblock.c.inc"
#  include "cx_pusheval.c.inc"
#endif

#if !HAVE_PERL_VERSION(5, 22, 0)
#  include "block_start.c.inc"
#  include "block_end.c.inc"

#  define CvPADLIST_set(cv, padlist)  (CvPADLIST(cv) = padlist)
#endif

#if !HAVE_PERL_VERSION(5, 18, 0)
#  define PadARRAY(pad)           AvARRAY(pad)
#  define PadMAX(pad)             AvFILLp(pad)

typedef AV PADNAMELIST;
#  define PadlistARRAY(pl)        ((PAD **)AvARRAY(pl))
#  define PadlistNAMES(pl)        (*PadlistARRAY(pl))

typedef SV PADNAME;
#  define PadnamePV(pn)           (SvPOKp(pn) ? SvPVX(pn) : NULL)
#  define PadnameLEN(pn)          SvCUR(pn)
#  define PadnameOUTER(pn)        !!SvFAKE(pn)
#  define PadnamelistARRAY(pnl)   AvARRAY(pnl)
#  define PadnamelistMAX(pnl)     AvFILLp(pnl)
#endif

typedef struct SuspendedFrame SuspendedFrame;
struct SuspendedFrame {
  SuspendedFrame *next;
  U8 type;
  U8 gimme;

  U32 stacklen;
  SV **stack;

  U32 marklen;
  I32 *marks;

  /* items from the save stack */
  U32 savedlen;
  struct Saved {
    U8 type;
    union {
      struct {
        PADOFFSET padix;
        U32 count;
      } clearpad;      /* for SAVEt_CLEARSV and SAVEt_CLEARPADRANGE */
      struct {
        void (*func)(pTHX_ void *data);
        void *data;
      } dx;            /* for SAVEt_DESTRUCTOR_X */
      GV *gv;          /* for SAVEt_SV + cur.sv, saved.sv */
      int *iptr;       /* for SAVEt_INT... */
      STRLEN *lenptr;  /* for SAVEt_STRLEN + cur.len, saved.len */
      PADOFFSET padix; /* for SAVEt_PADSV_AND_MORTALIZE */
      struct {
        SV *sv;
        U32 mask, set;
      } svflags;       /* for SAVEt_SET_SVFLAGS */
    } u;

    union {
      SV    *sv;      /* for SAVEt_SV, SAVEt_FREESV */
      void  *ptr;     /* for SAVEt_COMPPAD, */
      int    i;       /* for SAVEt_INT... */
      STRLEN len;     /* for SAVEt_STRLEN */
    } cur,    /* the current value that *thing that we should restore to */
      saved;  /* the saved value we should push to the savestack on restore */
  } *saved;

  union {
    struct {
      OP *retop;
    } eval;
    struct block_loop loop;
  } el;
#ifdef HAVE_ITERVAR
  SV *itervar;
#endif
};

typedef struct {
  SV *awaiting_future;   /* the Future that 'await' is currently waiting for */
  SV *returning_future;  /* the Future that its contining CV will eventually return */
  SuspendedFrame *frames;

  U32 padlen;
  SV **padslots;
} SuspendedState;

static void debug_sv_summary(const SV *sv)
{
  fprintf(stderr, "SV{type=%d,refcnt=%d", SvTYPE(sv), SvREFCNT(sv));

  if(SvROK(sv))
    fprintf(stderr, ",ROK");
  else if(SvIOK(sv))
    fprintf(stderr, ",IV=%" IVdf, SvIVX(sv));

  fprintf(stderr, "}");
}

static void debug_showstack(const char *name)
{
#ifdef DEBUG_SHOW_STACKS
  SV **sp;

  fprintf(stderr, "%s:\n", name ? name : "Stack");

  PERL_CONTEXT *cx = CX_CUR();

  I32 floor = cx->blk_oldsp;
  I32 *mark = PL_markstack + cx->blk_oldmarksp + 1;

  fprintf(stderr, "  marks (TOPMARK=@%d):\n", TOPMARK - floor);
  for(; mark <= PL_markstack_ptr; mark++)
    fprintf(stderr,  "    @%d\n", *mark - floor);

  mark = PL_markstack + cx->blk_oldmarksp + 1;
  for(sp = PL_stack_base + floor + 1; sp <= PL_stack_sp; sp++) {
    fprintf(stderr, sp == PL_stack_sp ? "-> " : "   ");
    fprintf(stderr, "%p = ", *sp);
    debug_sv_summary(*sp);
    while(mark <= PL_markstack_ptr && PL_stack_base + *mark == sp)
      fprintf(stderr, " [*M]"), mark++;
    fprintf(stderr, "\n");
  }
#endif
}

/*
 * Magic that we attach to suspended CVs, that contains state required to restore
 * them
 */

static MGVTBL vtbl = {
  NULL, /* get   */
  NULL, /* set   */
  NULL, /* len   */
  NULL, /* clear */
  NULL, /* free  - TODO?? */
};

#define suspendedstate_get(cv)  MY_suspendedstate_get(aTHX_ cv)
static SuspendedState *MY_suspendedstate_get(pTHX_ CV *cv)
{
  MAGIC *magic;

  for(magic = mg_find((SV *)cv, PERL_MAGIC_ext); magic; magic = magic->mg_moremagic)
    if(magic->mg_type == PERL_MAGIC_ext && magic->mg_virtual == &vtbl)
      return (SuspendedState *)magic->mg_ptr;

  return NULL;
}

#define suspendedstate_new(cv)  MY_suspendedstate_new(aTHX_ cv)
static SuspendedState *MY_suspendedstate_new(pTHX_ CV *cv)
{
  SuspendedState *ret;
  Newx(ret, 1, SuspendedState);

  ret->awaiting_future = NULL;
  ret->returning_future = NULL;
  ret->frames = NULL;

  sv_magicext((SV *)cv, NULL, PERL_MAGIC_ext, &vtbl, (char *)ret, 0);

  return ret;
}

#define suspend_block(frame, cx)  MY_suspend_block(aTHX_ frame, cx)
static void MY_suspend_block(pTHX_ SuspendedFrame *frame, PERL_CONTEXT *cx)
{
  /* The base of the stack within this context */
  SV **bp = PL_stack_base + cx->blk_oldsp + 1;
  I32 *markbase = PL_markstack + cx->blk_oldmarksp + 1;

  frame->stacklen = (I32)(PL_stack_sp - PL_stack_base)  - cx->blk_oldsp;
  if(frame->stacklen) {
    I32 i;
    /* Steal SVs right off the stack */
    Newx(frame->stack, frame->stacklen, SV *);
    for(i = 0; i < frame->stacklen; i++) {
      frame->stack[i] = bp[i];
      bp[i] = NULL;
    }
    PL_stack_sp = PL_stack_base + cx->blk_oldsp;
  }

  frame->marklen = (I32)(PL_markstack_ptr - PL_markstack) - cx->blk_oldmarksp;
  if(frame->marklen) {
    I32 i;
    Newx(frame->marks, frame->marklen, I32);
    for(i = 0; i < frame->marklen; i++) {
      /* Translate mark value relative to bp */
      I32 relmark = markbase[i] - cx->blk_oldsp;
      frame->marks[i] = relmark;
    }
    PL_markstack_ptr = PL_markstack + cx->blk_oldmarksp;
  }

  I32 old_saveix = OLDSAVEIX(cx);
  /* This is an over-estimate but it doesn't matter. We just waste a bit of RAM
   * temporarily
   */
  I32 savedlen = PL_savestack_ix - old_saveix;
  if(savedlen)
    Newx(frame->saved, savedlen, struct Saved);
  else
    frame->saved = NULL;
  frame->savedlen = 0; /* we increment it as we fill it */

  while(PL_savestack_ix > old_saveix) {
    /* Useful references
     *   scope.h
     *   scope.c: Perl_leave_scope()
     */

    UV uv = PL_savestack[PL_savestack_ix-1].any_uv;
    U8 type = (U8)uv & SAVE_MASK;

    struct Saved *saved = &frame->saved[frame->savedlen];

    switch(type) {
#ifdef SAVEt_CLEARPADRANGE
      case SAVEt_CLEARPADRANGE: {
        UV padix = uv >> (OPpPADRANGE_COUNTSHIFT + SAVE_TIGHT_SHIFT);
        I32 count = (uv >> SAVE_TIGHT_SHIFT) & OPpPADRANGE_COUNTMASK;
        PL_savestack_ix--;

        saved->type = count == 1 ? SAVEt_CLEARSV : SAVEt_CLEARPADRANGE;
        saved->u.clearpad.padix = padix;
        saved->u.clearpad.count = count;

        break;
      }
#endif

      case SAVEt_CLEARSV: {
        UV padix = (uv >> SAVE_TIGHT_SHIFT);
        PL_savestack_ix--;

        saved->type = SAVEt_CLEARSV;
        saved->u.clearpad.padix = padix;

        break;
      }

      case SAVEt_COMPPAD: {
        /* This occurs as a side-effect of Perl_pad_new on 5.22 */
        PL_savestack_ix -= 2;
        void *pad = PL_savestack[PL_savestack_ix].any_ptr;

        saved->type      = SAVEt_COMPPAD;
        saved->saved.ptr = pad;
        saved->cur.ptr   = PL_comppad;

        PL_comppad = pad;
        PL_curpad = PL_comppad ? AvARRAY(PL_comppad) : NULL;

        break;
      }

      case SAVEt_FREESV: {
        PL_savestack_ix -= 2;
        void *sv = PL_savestack[PL_savestack_ix].any_ptr;

        saved->type     = SAVEt_FREESV;
        saved->saved.sv = sv;

        break;
      }

      case SAVEt_INT_SMALL: {
        PL_savestack_ix -= 2;
        int val = ((int)uv >> SAVE_TIGHT_SHIFT);
        int *var = PL_savestack[PL_savestack_ix].any_ptr;

        /* In general we don't want to support this; but specifically on perls
         * older than 5.20, this might be PL_tmps_floor
         */
        if(var != (int *)&PL_tmps_floor)
          croak("TODO: Unsure how to handle a savestack entry of SAVEt_INT_SMALL with var != &PL_tmps_floor");

        saved->type    = SAVEt_INT;
        saved->u.iptr  = var;
        saved->cur.i   = *var;
        saved->saved.i = val;

        /* restore it for now */
        *var = val;

        break;
      }

      case SAVEt_DESTRUCTOR_X: {
        /* This is only known to be used by Syntax::Keyword::Try to implement
         * finally blocks. It may be found elsewhere for which this code is
         * unsafe, but detecting such cases is generally impossible. Good luck.
         */
        PL_savestack_ix -= 3;
        void (*func)(pTHX_ void *) = PL_savestack[PL_savestack_ix].any_dxptr;
        void *data                 = PL_savestack[PL_savestack_ix+1].any_ptr;

        saved->type = SAVEt_DESTRUCTOR_X;
        saved->u.dx.func = func;
        saved->u.dx.data = data;

        break;
      }

#ifdef SAVEt_STRLEN
      case SAVEt_STRLEN: {
        PL_savestack_ix -= 3;
        STRLEN  val = PL_savestack[PL_savestack_ix].any_iv;
        STRLEN *var = PL_savestack[PL_savestack_ix+1].any_ptr;

        /* In general we don't want to support this; but specifically on perls
         * older than 5.24, this might be PL_tmps_floor
         */
        if(var != (STRLEN *)&PL_tmps_floor)
          croak("TODO: Unsure how to handle a savestack entry of SAVEt_STRLEN with var != &PL_tmps_floor");

        saved->type      = SAVEt_STRLEN;
        saved->u.lenptr  = var;
        saved->cur.len   = *var;
        saved->saved.len = val;

        /* restore it for now */
        *var = val;

        break;
      }
#endif

      case SAVEt_SV: {
        PL_savestack_ix -= 3;
        /* despite being called SAVEt_SV, the first field actually points at
         * the GV containing the local'ised SV
         */
        GV *gv  = PL_savestack[PL_savestack_ix  ].any_ptr;
        SV *val = PL_savestack[PL_savestack_ix+1].any_ptr;

        /* In general we don't want to support local $VAR. However, a special
         * case of  local $@  is allowable
         * See also  https://rt.cpan.org/Ticket/Display.html?id=122793
         */
        if(gv != PL_errgv)
          croak("TODO: Unsure how to handle a savestack entry of SAVEt_SV with gv != PL_errgv");

        saved->type     = SAVEt_SV;
        saved->u.gv     = gv;
        saved->cur.sv   = GvSV(gv); /* steal ownership */
        saved->saved.sv = val;      /* steal ownership */

        /* restore it for now */
        GvSV(gv) = SvREFCNT_inc(val);

        break;
      }

      case SAVEt_PADSV_AND_MORTALIZE: {
        PL_savestack_ix -= 4;
        SV *val         = PL_savestack[PL_savestack_ix  ].any_ptr;
        AV *padav       = PL_savestack[PL_savestack_ix+1].any_ptr;
        PADOFFSET padix = PL_savestack[PL_savestack_ix+2].any_uv;

        if(padav != PL_comppad)
          croak("TODO: Unsure how to handle a savestack entry of SAVEt_PADSV_AND_MORTALIZE with padav != PL_comppad");

        SvREFCNT_inc(PL_curpad[padix]); /* un-mortalize */

        saved->type     = SAVEt_PADSV_AND_MORTALIZE;
        saved->u.padix  = padix;
        saved->cur.sv   = PL_curpad[padix]; /* steal ownership */
        saved->saved.sv = val;              /* steal ownership */

        AvARRAY(padav)[padix] = SvREFCNT_inc(val);

        break;
      }

      case SAVEt_SET_SVFLAGS: {
        PL_savestack_ix -= 4;
        SV *sv   = PL_savestack[PL_savestack_ix  ].any_ptr;
        U32 mask = (U32)PL_savestack[PL_savestack_ix+1].any_i32;
        U32 set  = (U32)PL_savestack[PL_savestack_ix+2].any_i32;

        saved->type           = SAVEt_SET_SVFLAGS;
        saved->u.svflags.sv   = sv;
        saved->u.svflags.mask = mask;
        saved->u.svflags.set  = set;

        break;
      }

      default:
        croak("TODO: Unsure how to handle savestack entry of %d", type);
    }

    frame->savedlen++;
  }

  if(OLDSAVEIX(cx) != PL_savestack_ix)
    croak("TODO: handle OLDSAVEIX");
}

static bool padname_is_normal_lexical(PADNAME *pname)
{
  /* PAD slots without names are certainly not lexicals */
  if(!pname ||
#if !HAVE_PERL_VERSION(5, 20, 0)
    /*  Perl before 5.20.0 could put PL_sv_undef in PADNAMEs */
    pname == &PL_sv_undef || 
#endif
    !PadnameLEN(pname))
    return FALSE;

  /* Outer lexical captures are not lexicals */
  if(PadnameOUTER(pname))
    return FALSE;

  /* Protosubs for closures are not lexicals */
  if(PadnamePV(pname)[0] == '&')
    return FALSE;

  /* anything left is a normal lexical */
  return TRUE;
}

#define cv_dup_for_suspend(orig)  MY_cv_dup_for_suspend(aTHX_ orig)
static CV *MY_cv_dup_for_suspend(pTHX_ CV *orig)
{
  /* Parts of this code stolen from S_cv_clone() in pad.c
   */
  CV *new = MUTABLE_CV(newSV_type(SVt_PVCV));
  CvFLAGS(new) = CvFLAGS(orig);

  CvFILE(new) = CvDYNFILE(orig) ? savepv(CvFILE(orig)) : CvFILE(orig);
#if HAVE_PERL_VERSION(5, 18, 0)
  if(CvNAMED(orig))
    CvNAME_HEK_set(new, share_hek_hek(CvNAME_HEK(orig)));
  else
#endif
    CvGV_set(new, CvGV(orig));
  CvSTASH_set(new, CvSTASH(orig));
  {
    OP_REFCNT_LOCK;
    CvROOT(new) = OpREFCNT_inc(CvROOT(orig));
    OP_REFCNT_UNLOCK;
  }
  CvSTART(new) = NULL; /* intentionally left NULL because caller should fill this in */
  CvOUTSIDE_SEQ(new) = CvOUTSIDE_SEQ(orig);

  /* No need to bother with SvPV slot because that's the prototype, and it's
   * too late for that here
   */

  {
    ENTER;

    SAVESPTR(PL_compcv);
    PL_compcv = new;

    CvOUTSIDE(new) = MUTABLE_CV(SvREFCNT_inc(CvOUTSIDE(orig)));

    SAVESPTR(PL_comppad_name);
    PL_comppad_name = PadlistNAMES(CvPADLIST(orig));
    CvPADLIST_set(new, pad_new(padnew_CLONE|padnew_SAVE));
#if HAVE_PERL_VERSION(5, 22, 0)
    CvPADLIST(new)->xpadl_id = CvPADLIST(orig)->xpadl_id;
#endif

    PADNAMELIST *padnames = PadlistNAMES(CvPADLIST(orig));
    const PADOFFSET fnames = PadnamelistMAX(padnames);
    const PADOFFSET fpad = AvFILLp(PadlistARRAY(CvPADLIST(orig))[1]);
    SV **origpad = AvARRAY(PadlistARRAY(CvPADLIST(orig))[CvDEPTH(orig)]);

#if !HAVE_PERL_VERSION(5, 18, 0)
/* Perls before 5.18.0 didn't copy the padnameslist
 */
    SvREFCNT_dec(PadlistNAMES(CvPADLIST(new)));
    PadlistNAMES(CvPADLIST(new)) = (PADNAMELIST *)SvREFCNT_inc(PadlistNAMES(CvPADLIST(orig)));
#endif

    av_fill(PL_comppad, fpad);
    PL_curpad = AvARRAY(PL_comppad);

    PADNAME **pnames = PadnamelistARRAY(padnames);
    PADOFFSET padix;
    for(padix = 1; padix <= fpad; padix++) {
      PADNAME *pname = (padix <= fnames) ? pnames[padix] : NULL;
      SV *newval;

      if(padname_is_normal_lexical(pname)) {
        /* No point copying a normal lexical slot because the suspend logic is
         * about to capture all the pad slots from the running CV (orig) and
         * they'll be restored into this new one later by resume.
         */
        continue;
      }
      else if(pname && PadnamePV(pname)) {
#if !HAVE_PERL_VERSION(5, 18, 0)
        /* Before perl 5.18.0, inner anon subs didn't find the right CvOUTSIDE
         * at runtime, so we'll have to patch them up here
         */
        CV *origproto;
        if(PadnamePV(pname)[0] == '&' && 
           CvOUTSIDE(origproto = MUTABLE_CV(origpad[padix])) == orig) {
          /* quiet any "Variable $FOO is not available" warnings about lexicals
           * yet to be introduced
           */
          ENTER;
          SAVEINT(CvDEPTH(origproto));
          CvDEPTH(origproto) = 1;

          CV *newproto = cv_dup_for_suspend(origproto);
          CvPADLIST_set(newproto, CvPADLIST(origproto));
          CvSTART(newproto) = CvSTART(origproto);

          SvREFCNT_dec(CvOUTSIDE(newproto));
          CvOUTSIDE(newproto) = MUTABLE_CV(SvREFCNT_inc_simple_NN(new));

          LEAVE;

          newval = MUTABLE_SV(newproto);
        }
        else if(origpad[padix])
          newval = SvREFCNT_inc_NN(origpad[padix]);
#else
        newval = SvREFCNT_inc_NN(origpad[padix]);
#endif
      }
      else {
        newval = newSV(0);
        SvPADTMP_on(newval);
      }

      PL_curpad[padix] = newval;
    }

    LEAVE;
  }

  return new;
}

#define suspendedstate_suspend(state, cv)  MY_suspendedstate_suspend(aTHX_ state, cv)
static void MY_suspendedstate_suspend(pTHX_ SuspendedState *state, CV *cv)
{
  I32 cxix;
  PADOFFSET padnames_max, pad_max, i;
  PADLIST *plist;
  PADNAME **padnames;
  PAD *pad;

  state->frames = NULL;

  for(cxix = cxstack_ix; cxix; cxix--) {
    PERL_CONTEXT *cx = &cxstack[cxix];
    if(CxTYPE(cx) == CXt_SUB)
      break;

    SuspendedFrame *frame;

    Newx(frame, 1, SuspendedFrame);
    frame->next = state->frames;
    state->frames = frame;

    suspend_block(frame, cx);

    /* ref:
     *   https://perl5.git.perl.org/perl.git/blob/HEAD:/cop.h
     */
    U8 type = CxTYPE(cx);
    switch(type) {
      case CXt_BLOCK:
        frame->type = CXt_BLOCK;
        frame->gimme = cx->blk_gimme;
        /* nothing else special */
        continue;

      case CXt_LOOP_PLAIN:
        frame->type = type;
        frame->el.loop = cx->blk_loop;
        frame->gimme = cx->blk_gimme;
        break;

#if HAVE_PERL_VERSION(5, 24, 0)
      case CXt_LOOP_ARY:
      case CXt_LOOP_LIST:
#else
      case CXt_LOOP_FOR:
#endif
      case CXt_LOOP_LAZYSV:
      case CXt_LOOP_LAZYIV:
        if(!CxPADLOOP(cx))
          /* non-lexical foreach will effectively work like 'local' and we
           * can't really support local
           */
          croak("Cannot suspend a foreach loop on non-lexical iterator");

        frame->type = type;
        frame->el.loop = cx->blk_loop;
        frame->gimme = cx->blk_gimme;

#ifdef HAVE_ITERVAR
#  ifdef USE_ITHREADS
        if(cx->blk_loop.itervar_u.svp != (SV **)PL_comppad)
          croak("TODO: Unsure how to handle a foreach loop with itervar != PL_comppad");
#  else
        if(cx->blk_loop.itervar_u.svp != &PAD_SVl(cx->blk_loop.my_op->op_targ))
          croak("TODO: Unsure how to handle a foreach loop with itervar != PAD_SVl(op_targ))");
#  endif

        frame->itervar = SvREFCNT_inc(*CxITERVAR(cx));
#else
        if(CxITERVAR(cx) != &PAD_SVl(cx->blk_loop.my_op->op_targ))
          croak("TODO: Unsure how to handle a foreach loop with itervar != PAD_SVl(op_targ))");
        SvREFCNT_inc(cx->blk_loop.itersave);
#endif

        if(type == CXt_LOOP_LAZYSV) {
          /* these two fields are refcounted, so we need to save them from
           * dounwind() throwing them away
           */
          SvREFCNT_inc(frame->el.loop.state_u.lazysv.cur);
          SvREFCNT_inc(frame->el.loop.state_u.lazysv.end);
        }
#if !HAVE_PERL_VERSION(5, 24, 0)
        else if(type == CXt_LOOP_FOR) {
          if(frame->el.loop.state_u.ary.ary)
            SvREFCNT_inc(frame->el.loop.state_u.ary.ary);
        }
#endif

        continue;

      case CXt_EVAL: {
        if(!(cx->cx_type & CXp_TRYBLOCK))
          croak("TODO: handle CXt_EVAL without CXp_TRYBLOCK");
        if(cx->blk_eval.old_namesv)
          croak("TODO: handle cx->blk_eval.old_namesv");
        if(cx->blk_eval.old_eval_root)
          croak("TODO: handle cx->blk_eval.old_eval_root");
        if(cx->blk_eval.cur_text)
          croak("TODO: handle cx->blk_eval.cur_text");
        if(cx->blk_eval.cv)
          croak("TODO: handle cx->blk_eval.cv");
        if(cx->blk_eval.cur_top_env != PL_top_env)
          croak("TODO: handle cx->blk_eval.cur_top_env");

        frame->type = CXt_EVAL;
        frame->gimme = cx->blk_gimme;

        frame->el.eval.retop = cx->blk_eval.retop;

        continue;
      }

      default:
        croak("TODO: unsure how to handle a context frame of type %d", CxTYPE(cx));
    }
  }

  /* Now steal the lexical SVs from the PAD */
  plist = CvPADLIST(cv);

  padnames = PadnamelistARRAY(PadlistNAMES(plist));
  padnames_max = PadnamelistMAX(PadlistNAMES(plist));

  pad = PadlistARRAY(plist)[CvDEPTH(cv)];
  pad_max = PadMAX(pad);

  state->padlen = PadMAX(pad) + 1;
  Newx(state->padslots, state->padlen - 1, SV *);

  /* slot 0 is always the @_ AV */
  for(i = 1; i <= pad_max; i++) {
    PADNAME *pname = (i <= padnames_max) ? padnames[i] : NULL;

    if(!padname_is_normal_lexical(pname)) {
      state->padslots[i-1] = NULL;
      continue;
    }

    /* Don't fiddle refcount */
    state->padslots[i-1] = PadARRAY(pad)[i];
    PadARRAY(pad)[i] = newSV(0);
  }

  dounwind(cxix);
}

#define resume_block(frame, cx)  MY_resume_block(aTHX_ frame, cx)
static void MY_resume_block(pTHX_ SuspendedFrame *frame, PERL_CONTEXT *cx)
{
  I32 i;

  if(frame->stacklen) {
    dSP;
    EXTEND(SP, frame->stacklen);

    for(i = 0; i < frame->stacklen; i++) {
      PUSHs(frame->stack[i]);
    }

    Safefree(frame->stack);
    PUTBACK;
  }

  if(frame->marklen) {
    for(i = 0; i < frame->marklen; i++) {
      I32 absmark = frame->marks[i] + cx->blk_oldsp;
      PUSHMARK(PL_stack_base + absmark);
    }

    Safefree(frame->marks);
  }

  for(i = frame->savedlen - 1; i >= 0; i--) {
    struct Saved *saved = &frame->saved[i];

    switch(saved->type) {
      case SAVEt_CLEARSV:
        save_clearsv(PL_curpad + saved->u.clearpad.padix);
        break;

#ifdef SAVEt_CLEARPADRANGE
      case SAVEt_CLEARPADRANGE:
        save_clearpadrange(saved->u.clearpad.padix, saved->u.clearpad.count);
        break;
#endif

      case SAVEt_DESTRUCTOR_X:
        save_pushptrptr(saved->u.dx.func, saved->u.dx.data, saved->type);
        break;

      case SAVEt_COMPPAD:
        PL_comppad = saved->saved.ptr;
        save_pushptr(PL_comppad, saved->type);

        PL_comppad = saved->cur.ptr;
        PL_curpad = PL_comppad ? AvARRAY(PL_comppad) : NULL;
        break;

      case SAVEt_FREESV:
        save_freesv(saved->saved.sv);
        break;

      case SAVEt_INT:
        *(saved->u.iptr) = saved->saved.i;
        save_int(saved->u.iptr);

        *(saved->u.iptr) = saved->cur.i;
        break;

      case SAVEt_SV:
        save_pushptrptr(saved->u.gv, saved->saved.sv, SAVEt_SV);

        SvREFCNT_dec(GvSV(saved->u.gv));
        GvSV(saved->u.gv) = saved->cur.sv;
        break;

#ifdef SAVEt_STRLEN
      case SAVEt_STRLEN:
        *(saved->u.lenptr) = saved->saved.len;
        Perl_save_strlen(aTHX_ saved->u.lenptr);

        *(saved->u.lenptr) = saved->cur.len;
        break;
#endif

      case SAVEt_PADSV_AND_MORTALIZE:
        /*
        PL_curpad[saved->u.padix] = saved->saved.sv;
        save_padsv_and_mortalize(saved->u.padix);

        SvREFCNT_dec(PL_curpad[saved->u.padix]);
        PL_curpad[saved->u.padix] = saved->cur.sv;
        */
        break;

      case SAVEt_SET_SVFLAGS:
        /*
        save_set_svflags(saved->u.svflags.sv,
          saved->u.svflags.mask, saved->u.svflags.set);
        */
        break;

      default:
        croak("TODO: Unsure how to restore a %d savestack entry\n", saved->type);
    }
  }

  if(frame->saved)
    Safefree(frame->saved);
}

#define suspendedstate_resume(state, cv)  MY_suspendedstate_resume(aTHX_ state, cv)
static void MY_suspendedstate_resume(pTHX_ SuspendedState *state, CV *cv)
{
  if(state->padlen) {
    PAD *pad = PadlistARRAY(CvPADLIST(cv))[CvDEPTH(cv)];
    PADOFFSET i;

    /* slot 0 is always the @_ AV */
    for(i = 1; i < state->padlen; i++) {
      if(!state->padslots[i-1])
        continue;

      SvREFCNT_dec(PadARRAY(pad)[i]);
      PadARRAY(pad)[i] = state->padslots[i-1];
    }
  }

  SuspendedFrame *frame, *next;
  for(frame = state->frames; frame; frame = next) {
    next = frame->next;

    PERL_CONTEXT *cx;

    switch(frame->type) {
      case CXt_BLOCK:
        cx = cx_pushblock(CXt_BLOCK, frame->gimme, PL_stack_sp, PL_savestack_ix);
        /* nothing else special */
        break;

      case CXt_LOOP_PLAIN:
        cx = cx_pushblock(frame->type, frame->gimme, PL_stack_sp, PL_savestack_ix);
        /* don't call cx_pushloop_plain() because it will get this wrong */
        cx->blk_loop = frame->el.loop;
        break;

#if HAVE_PERL_VERSION(5, 24, 0)
      case CXt_LOOP_ARY:
      case CXt_LOOP_LIST:
#else
      case CXt_LOOP_FOR:
#endif
      case CXt_LOOP_LAZYSV:
      case CXt_LOOP_LAZYIV:
        cx = cx_pushblock(frame->type, frame->gimme, PL_stack_sp, PL_savestack_ix);
        /* don't call cx_pushloop_plain() because it will get this wrong */
        cx->blk_loop = frame->el.loop;
#if HAVE_PERL_VERSION(5, 24, 0)
        cx->cx_type |= CXp_FOR_PAD;
#endif

#ifdef HAVE_ITERVAR
#  ifdef USE_ITHREADS
        cx->blk_loop.itervar_u.svp = (SV **)PL_comppad;
#  else 
        cx->blk_loop.itervar_u.svp = &PAD_SVl(cx->blk_loop.my_op->op_targ);
#  endif
        SvREFCNT_dec(*CxITERVAR(cx));
        *CxITERVAR(cx) = frame->itervar;
#else
        cx->blk_loop.itervar_u.svp = &PAD_SVl(cx->blk_loop.my_op->op_targ);
#endif
        break;

      case CXt_EVAL:
        cx = cx_pushblock(CXt_EVAL|CXp_TRYBLOCK, frame->gimme,
          PL_stack_sp, PL_savestack_ix);
        cx_pusheval(cx, frame->el.eval.retop, NULL);
        PL_in_eval = EVAL_INEVAL;
        CLEAR_ERRSV();
        break;

      default:
        croak("TODO: Unsure how to restore a %d frame\n", frame->type);
    }

    resume_block(frame, cx);

    Safefree(frame);
  }
}

/*
 * Some Future class helper functions
 */

#define future_done_from_stack(f, mark)  MY_future_done_from_stack(aTHX_ f, mark)
static SV *MY_future_done_from_stack(pTHX_ SV *f, SV **mark)
{
  dSP;
  SV **svp;

  EXTEND(SP, 1);

  ENTER;
  SAVETMPS;

  PUSHMARK(mark);
  SV **bottom = mark + 1;

  /* splice the class name 'Future' in to the start of the stack */

  for (svp = SP; svp >= bottom; svp--) {
    *(svp+1) = *svp;
  }
  if(f)
    *bottom = SvREFCNT_inc(f);
  else
    *bottom = sv_2mortal(newSVpvn("Future", 6));
  SP++;
  PUTBACK;

  call_method("done", G_SCALAR);

  SPAGAIN;

  SV *ret = SvREFCNT_inc(POPs);

  FREETMPS;
  LEAVE;

  return ret;
}

#define future_fail(f, failure)  MY_future_fail(aTHX_ f, failure)
static SV *MY_future_fail(pTHX_ SV *f, SV *failure)
{
  dSP;

  ENTER;
  SAVETMPS;

  PUSHMARK(SP);
  if(f)
    PUSHs(SvREFCNT_inc(f));
  else
    mPUSHp("Future", 6);
  mPUSHs(newSVsv(failure));
  PUTBACK;

  call_method("fail", G_SCALAR);

  SPAGAIN;

  SV *ret = SvREFCNT_inc(POPs);

  FREETMPS;
  LEAVE;

  return ret;
}

#define future_new_from_proto(proto)  MY_future_new_from_proto(aTHX_ proto)
static SV *MY_future_new_from_proto(pTHX_ SV *proto)
{
  dSP;

  ENTER;
  SAVETMPS;

  PUSHMARK(SP);
  PUSHs(proto);
  PUTBACK;

  call_method("new", G_SCALAR);

  SPAGAIN;

  SV *f = SvREFCNT_inc(POPs);

  FREETMPS;
  LEAVE;

  if(!SvROK(f))
    croak("Expected Future->new to yield a new reference");

  assert(SvREFCNT(f) == 1);
  assert(SvREFCNT(SvRV(f)) == 1);
  return f;
}

#define future_is_ready(f)  MY_future_is_ready(aTHX_ f)
static int MY_future_is_ready(pTHX_ SV *f)
{
  dSP;

  ENTER;
  SAVETMPS;

  PUSHMARK(SP);
  XPUSHs(f);
  PUTBACK;

  call_method("is_ready", G_SCALAR);

  SPAGAIN;

  int is_ready = POPi;

  PUTBACK;
  FREETMPS;
  LEAVE;

  return is_ready;
}

#define future_get_to_stack(f, gimme)  MY_future_get_to_stack(aTHX_ f, gimme)
static void MY_future_get_to_stack(pTHX_ SV *f, I32 gimme)
{
  dSP;

  ENTER;

  PUSHMARK(SP);
  XPUSHs(f);
  PUTBACK;

  call_method("get", gimme);

  LEAVE;
}

#define future_on_ready(f, code)  MY_future_on_ready(aTHX_ f, code)
static void MY_future_on_ready(pTHX_ SV *f, CV *code)
{
  dSP;

  ENTER;

  PUSHMARK(SP);
  XPUSHs(f);
  mXPUSHs(newRV_inc((SV *)code));
  PUTBACK;

  call_method("on_ready", G_VOID);

  LEAVE;
}

/*
 * Custom ops
 */

static XOP xop_leaveasync;
static OP *pp_leaveasync(pTHX)
{
  dSP;
  dMARK;

  PERL_CONTEXT *cx = CX_CUR();
  SV *f = NULL;
  SV *ret;
  SV **oldsp = PL_stack_base + cx->blk_oldsp;

  SuspendedState *state = suspendedstate_get(find_runcv(0));
  if(state && state->returning_future)
    f = state->returning_future;

  if(SvTRUE(ERRSV)) {
    ret = future_fail(f, ERRSV);
  }
  else {
    ret = future_done_from_stack(f, mark);
  }

  /* Pop extraneous stack items */
  while(SP > oldsp)
    POPs;

  PUSHs(ret);
  PUTBACK;

  return PL_op->op_next;
}

static OP *newLEAVEASYNCOP(I32 flags)
{
  OP *op = newOP(OP_CUSTOM, flags);
  op->op_ppaddr = &pp_leaveasync;

  return op;
}

static XOP xop_await;
static OP *pp_await(pTHX)
{
  /* We arrive here in either of two cases:
   *   1) Normal code flow has executed an 'await F' expression
   *   2) A previous await operation is resuming
   * Distinguish which by inspecting the state (if any) of the suspended context
   * magic on the containing CV
   */
  dSP;
  SV *f;

  CV *curcv = find_runcv(0);
  CV *origcv = curcv;

  SuspendedState *state = suspendedstate_get(curcv);

  if(state && state->awaiting_future) {
    I32 orig_height;

    f = state->awaiting_future;
    state->awaiting_future = NULL;

    /* Before we restore the stack we first need to POP the caller's
     * arguments, as we don't care about those
     */
    orig_height = CX_CUR()->blk_oldsp;
    while(sp > PL_stack_base + orig_height)
      POPs;
    PUTBACK;

    /* We also need to clean up the markstack and insert a new mark at the
     * beginning
     */
    orig_height = CX_CUR()->blk_oldmarksp;
    while(PL_markstack_ptr > PL_markstack + orig_height)
      POPMARK;
    PUSHMARK(SP);

    suspendedstate_resume(state, curcv);

    debug_showstack("Stack after resume");
  }
  else {
    f = POPs;
    PUTBACK;
  }

  if(!sv_isobject(f))
    croak("Expected a blessed object reference to await");

  if(future_is_ready(f)) {
    assert(CvDEPTH(curcv) > 0);
    /* This might throw */
    future_get_to_stack(f, GIMME_V);
    return PL_op->op_next;
  }

  debug_showstack("Stack before suspend");

  if(!state) {
    /* Clone the CV and then attach suspendedstate magic to it */
    curcv = cv_dup_for_suspend(curcv);
    state = suspendedstate_new(curcv);
  }

  suspendedstate_suspend(state, origcv);

  CvSTART(curcv) = PL_op; /* resume from here */
  future_on_ready(f, curcv);

  state->awaiting_future = SvREFCNT_inc(f);

  if(!state->returning_future)
    state->returning_future = future_new_from_proto(f);

  PUSHMARK(SP);
  PUSHs(state->returning_future);
  PUTBACK;

  return PL_ppaddr[OP_RETURN](aTHX);
}

static OP *newAWAITOP(I32 flags, OP *expr)
{
  OP *op = newUNOP(OP_CUSTOM, flags, expr);
  op->op_ppaddr = &pp_await;

  return op;
}

/*
 * Lexer extensions
 */

#define lex_consume(s)  MY_lex_consume(aTHX_ s)
static int MY_lex_consume(pTHX_ char *s)
{
  /* I want strprefix() */
  size_t i;
  for(i = 0; s[i]; i++) {
    if(s[i] != PL_parser->bufptr[i])
      return 0;
  }

  lex_read_to(PL_parser->bufptr + i);
  return i;
}

#define sv_cat_c(sv, c)  MY_sv_cat_c(aTHX_ sv, c)
static void MY_sv_cat_c(pTHX_ SV *sv, U32 c)
{
  char ds[UTF8_MAXBYTES + 1], *d;
  d = (char *)uvchr_to_utf8((U8 *)ds, c);
  if (d - ds > 1) {
    sv_utf8_upgrade(sv);
  }
  sv_catpvn(sv, ds, d - ds);
}

#define lex_scan_ident()  MY_lex_scan_ident(aTHX)
static SV *MY_lex_scan_ident(pTHX)
{
  /* Inspired by
   *   https://metacpan.org/source/MAUKE/Function-Parameters-1.0705/Parameters.xs#L265
   */
  I32 c;
  bool at_start;
  SV *ret = newSVpvs("");
  if(lex_bufutf8())
    SvUTF8_on(ret);

  at_start = TRUE;

  c = lex_peek_unichar(0);

  while(c != -1) {
    if(at_start ? isIDFIRST_uni(c) : isALNUM_uni(c)) {
      at_start = FALSE;
      sv_cat_c(ret, lex_read_unichar(0));

      c = lex_peek_unichar(0);
    }
    else
      break;
  }

  if(SvCUR(ret))
    return ret;

  SvREFCNT_dec(ret);
  return NULL;
}

/*
 * Keyword plugins
 */

static int async_keyword_plugin(pTHX_ OP **op_ptr)
{
  lex_read_space(0);

  /* At this point we want to parse the sub NAME BLOCK or sub BLOCK
   * We can't just call parse_fullstmt because that will do too much that we
   *   can't hook into. We'll have to go a longer way round.
   */

  /* async must be immediately followed by 'sub' */
  if(!lex_consume("sub"))
    croak("Expected async to be followed by sub");
  lex_read_space(0);

  /* Might be named or anonymous */
  SV *name = lex_scan_ident();
  lex_read_space(0);

  if(lex_peek_unichar(0) != '{')
    croak("Expected async sub %sto be followed by '{'", name ? "NAME " : "");

  I32 floor_ix = start_subparse(FALSE, name ? 0 : CVf_ANON);
  SAVEFREESV(PL_compcv);

  /* Save the identity of the currently-compiling sub so that 
   * await_keyword_plugin() can check
   */
  hv_stores(GvHV(PL_hintgv), "Future::AsyncAwait/PL_compcv", newRV((SV *)PL_compcv));

  I32 save_ix = block_start(TRUE);

  OP *body = parse_block(0);

  SvREFCNT_inc(PL_compcv);
  body = block_end(save_ix, body);

  /* turn block into
   *    PUSHMARK; eval { BLOCK }; LEAVEASYNC
   */

  OP *op = newLISTOP(OP_LINESEQ, 0, newOP(OP_PUSHMARK, 0), NULL);

  OP *try;
  op = op_append_elem(OP_LINESEQ, op, try = newUNOP(OP_ENTERTRY, 0, body));
  op_contextualize(try, G_ARRAY);

  op = op_append_elem(OP_LINESEQ, op, newLEAVEASYNCOP(OPf_WANT_SCALAR));

  CV *cv = newATTRSUB(floor_ix,
    name ? newSVOP(OP_CONST, 0, SvREFCNT_inc(name)) : NULL,
    NULL,
    NULL,
    op);

  if(name) {
    *op_ptr = newOP(OP_NULL, 0);

    SvREFCNT_dec(name);
    return KEYWORD_PLUGIN_STMT;
  }
  else {
    *op_ptr = newUNOP(OP_REFGEN, 0,
      newSVOP(OP_ANONCODE, 0, (SV *)cv));

    return KEYWORD_PLUGIN_EXPR;
  }
}

static int await_keyword_plugin(pTHX_ OP **op_ptr)
{
  SV **asynccvrefp = hv_fetchs(GvHV(PL_hintgv), "Future::AsyncAwait/PL_compcv", 0);
  if(!asynccvrefp || !*asynccvrefp ||
     SvRV(*asynccvrefp) != (SV *)PL_compcv)
    croak("Cannot 'await' outside of an 'async sub'");

  lex_read_space(0);

  OP *expr;
  /* await TERMEXPR wants a single term expression
   * await( FULLEXPR ) will be a full expression */
  if(lex_peek_unichar(0) == '(') {
    lex_read_unichar(0);

    expr = parse_fullexpr(0);

    lex_read_space(0);

    if(lex_peek_unichar(0) != ')')
      croak("Expected ')'");
    lex_read_unichar(0);
  }
  else
    expr = parse_termexpr(0);

  *op_ptr = newAWAITOP(0, expr);

  return KEYWORD_PLUGIN_EXPR;
}

static int (*next_keyword_plugin)(pTHX_ char *, STRLEN, OP **);

static int my_keyword_plugin(pTHX_ char *kw, STRLEN kwlen, OP **op_ptr)
{
  HV *hints = GvHV(PL_hintgv);

  if((PL_parser && PL_parser->error_count) ||
     !hints)
    return (*next_keyword_plugin)(aTHX_ kw, kwlen, op_ptr);

  if(kwlen == 5 && strEQ(kw, "async") &&
      hv_fetchs(hints, "Future::AsyncAwait/async", 0))
    return async_keyword_plugin(aTHX_ op_ptr);

  if(kwlen == 5 && strEQ(kw, "await") &&
      hv_fetchs(hints, "Future::AsyncAwait/async", 0))
    return await_keyword_plugin(aTHX_ op_ptr);

  return (*next_keyword_plugin)(aTHX_ kw, kwlen, op_ptr);
}

MODULE = Future::AsyncAwait    PACKAGE = Future::AsyncAwait

BOOT:
  XopENTRY_set(&xop_leaveasync, xop_name, "leaveasync");
  XopENTRY_set(&xop_leaveasync, xop_desc, "leaveasync()");
  XopENTRY_set(&xop_leaveasync, xop_class, OA_UNOP);
  Perl_custom_op_register(aTHX_ &pp_leaveasync, &xop_leaveasync);

  XopENTRY_set(&xop_await, xop_name, "await");
  XopENTRY_set(&xop_await, xop_desc, "await()");
  XopENTRY_set(&xop_await, xop_class, OA_UNOP);
  Perl_custom_op_register(aTHX_ &pp_await, &xop_await);

  next_keyword_plugin = PL_keyword_plugin;
  PL_keyword_plugin = &my_keyword_plugin;
