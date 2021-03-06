/*
 * @(#)$Id: dbdimp.h,v 2013.1 2013/01/18 19:39:15 jleffler Exp $
 *
 * Copyright 1994-95 Tim Bunce
 * Copyright 1996-99 Jonathan Leffler
 * Copyright 2000    Informix Software Inc
 * Copyright 2001-02 IBM
 * Copyright 2003-13 Jonathan Leffler
 *
 * You may distribute under the terms of either the GNU General Public
 * License or the Artistic License, as specified in the Perl README file.
 */

#ifndef DBDIMP_H
#define DBDIMP_H

#ifdef MAIN_PROGRAM
#ifndef lint
/* Prevent over-aggressive optimizers from eliminating ID string */
extern const char jlss_id_dbdimp_h[];
const char jlss_id_dbdimp_h[] = "@(#)$Id: dbdimp.h,v 2013.1 2013/01/18 19:39:15 jleffler Exp $";
#endif /* lint */
#endif /* MAIN_PROGRAM */

/**
** Handle assert.
** A test '#ifndef assert' was added around #include <assert.h> by Jan Iven
** <j.iven@rz.uni-sb.de> for Linux in October 1998.  The test was removed
** in November 1998 by Jonathan Leffler in favour of rewriting the whole
** test block because assertions are needed during development and the
** empty form of assert() was defined somewhere along the line.
** Makefile.PL has been modified so that the explicit environment variable
** DBD_INFORMIX_ENABLE_ASSERT has to be set for assertions to be active.
**                  Caveat developer!
** This code below assumes that <assert.h> has been implemented accurately
** everywhere, which has not always been the case.  Specifically, at least
** one platform did not notice changes in NDEBUG even though the ANSI
** standard clearly states that it must.  Let's hope...
*/
#undef assert
#undef NDEBUG
#ifndef DBD_INFORMIX_ENABLE_ASSERT
#define NDEBUG
#endif /* DBD_INFORMIX_ENABLE_ASSERT */
#include <assert.h>

#include "dbdixmap.h"   /* Defines for functions called in Informix.xs */
#include "esqlc.h"      /* Prototypes for ESQL/C version 5.0x etc */
#include "esqlperl.h"   /* Declarations for code used in esqltest.ec */
#include "link.h"       /* Declares Link data type and functions */
#include "kludge.h"     /* Support for documenting kludges in code */

/*
** Note that although 9.2 servers (IDS.2000 and Foundation.2000)
** support names longer than 18 characters, the value of NAMESIZE
** is used only for names generated by DBD::Informix, and does
** not need to be increased to 128 or 129.
*/
#define NAMESIZE 19             /* 18 character name plus '\0' */
#define DEFAULT_DATABASE    ".DEFAULT."

/*
** IUS BLOB and CLOB types need special treatment, but are
** of type SQLUDTFIXED in the Informix system catalogue.
** Hence invent a pair of numbers to represent them.
*/
#define DBD_IX_SQLBLOB  (1000+SQLBYTES)
#define DBD_IX_SQLCLOB  (1000+SQLTEXT)

/* Different states for a statement */
enum State
{
    Unused, Prepared, Allocated, Described, Declared, Opened, NoMoreData
};

typedef enum State State;       /* Cursor/Statement states */
typedef long ErrNum;            /* Informix Error Number */
typedef char Name[NAMESIZE];    /* ESQL Object Names */
/* ESQL Object Names covers connection, descriptor, cursor, statement names */

/* Define drh implementor data structure */
struct imp_drh_st
{
    dbih_drc_t      com;        /* MUST be first element in structure   */
    Boolean         multipleconnections;/* Supports multiple connections */
    int             n_connections;      /* Number of active connections */
    const char     *current_connection; /* Name of current connection */
    Link            head;               /* Head of list of connections */
};

/* Define dbh implementor data structure */
struct imp_dbh_st
{
    dbih_dbc_t      com;            /* MUST be first element in structure */
    SV             *database;       /* Name of database */
    Name            nm_connection;  /* Name of connection */
    Boolean         is_connected;   /* Is connection open */
    Boolean         is_onlinedb;    /* Is OnLine Engine */
    Boolean         is_modeansi;    /* Is MODE ANSI Database */
    Boolean         is_loggeddb;    /* Has transaction log */
    Boolean         is_txactive;    /* Is inside transaction */
    Boolean         no_replication; /* Use BEGIN WORK WITHOUT REPLICATION? */
    Boolean         has_procs;      /* Has stored procedures (not 8.[012]x) */
    Boolean         has_blobs;      /* Has blobs (not SE nor 8.[012]x) */
    int             srvr_vrsn;      /* Server version number (eg 510 or 731) */
    SV             *srvr_name;      /* Server version name (DBINFO('version','full')) */
    BlobLocn        blob_bind;      /* Blob binding */
    Sqlca           ix_sqlca;       /* Last SQLCA record for connection */
    ifx_int8_t      ix_serial8;     /* Last SERIAL8 value inserted on connection */
#ifdef ESQLC_BIGINT
    bigint          ix_bigserial;   /* Last BIGSERIAL value inserted on connection */
#endif /* ESQLC_BIGINT */
    Link            chain;          /* Link in list of connections */
    Link            head;           /* Head of list of statements */
    long            dbh_pid;        /* PID of Perl process creating handle */
    Boolean         enable_utf8;    /* Option ix_EnableUTF8 passed */
};

/* Define sth implementor data structure */
struct imp_sth_st
{
    dbih_stc_t      com;        /* MUST be first element in structure   */
    Name            nm_stmnt;   /* Name of prepared statement */
    Name            nm_obind;   /* Name of output descriptor */
    Name            nm_cursor;  /* Name of declared cursor */
    Name            nm_ibind;   /* Name of input descriptor */
    State           st_state;   /* State of statement */
    int             st_type;    /* Type of statement */
    SV             *st_text;    /* Text of statement */
    BlobLocn        blob_bind;  /* Blob Binding */
    int             n_iblobs;   /* Number of blobs in input descriptor */
    int             n_oblobs;   /* Number of blobs in output descriptor */
    int             n_ocols;    /* Number of output fields */
    int             n_icols;    /* Number of input fields */
    int             n_rows;     /* Number of rows processed */
    int             n_iudts;    /* Number of UDTs in input descriptor */
    int             n_oudts;    /* Number of UDTs in output descriptor */
    void          **a_iudts;    /* Array of lvarchar pointers for input UDTs */
    void          **a_oudts;    /* Array of lvarchar pointers for output UDTs */
    int             n_lvcsz;    /* Number of LVARCHAR (not UDT) columns */
    int            *a_lvcsz;    /* Array of integers holding LVARCHAR sizes */
    Boolean         is_holdcursor;  /* Using a hold Cursor */
    Boolean         is_scrollcursor;    /* Using a scroll Cursor */
    Boolean         is_insertcursor;    /* Using a insert Cursor */
    imp_dbh_t      *dbh;        /* Database handle for statement */
    Link            chain;      /* Link in list of statements */
};

#define DBI_AutoCommit(dbh) (DBIc_is(dbh, DBIcf_AutoCommit) ? True : False)

#ifndef DBD_IX_MODULE
#define DBD_IX_MODULE "DBD::Informix"
#endif /* DBD_IX_MODULE */

/* Standard driver entry points */
extern int dbd_ix_dr_discon_all(SV *, imp_drh_t *);
extern void dbd_ix_dr_init(dbistate_t *);

/* Non-standard driver entry points */
extern SV *dbd_ix_dr_FETCH_attrib(imp_drh_t *drh, SV *keysv);
extern int dbd_ix_dr_driver(SV *drh);
extern AV *dbd_ix_dr_data_sources(SV *drh, imp_drh_t *imp_drh, SV *attr);

/* Standard database entry points */
extern SV *dbd_ix_db_FETCH_attrib(SV *, imp_dbh_t *, SV *);
extern int dbd_ix_db_STORE_attrib(SV *, imp_dbh_t *, SV *, SV *);
extern int dbd_ix_db_commit(SV *, imp_dbh_t *);
extern int dbd_ix_db_disconnect(SV *, imp_dbh_t *);
extern int dbd_ix_db_connect(SV *, imp_dbh_t *, char *, char *, char *, SV *);
extern int dbd_ix_db_rollback(SV *, imp_dbh_t *);
extern void dbd_ix_db_destroy(SV *, imp_dbh_t *);

/* Non-standard database entry points */
extern int dbd_ix_db_begin(imp_dbh_t *);

/* Standard statement entry points */
extern AV *dbd_ix_st_fetch(SV *, imp_sth_t *);
extern SV *dbd_ix_st_FETCH_attrib(SV *, imp_sth_t *, SV *);
extern int dbd_ix_st_STORE_attrib(SV *, imp_sth_t *, SV *, SV *);
extern int dbd_ix_st_bind_ph(SV *, imp_sth_t *, SV *, SV *, IV, SV *, int, IV);
extern int dbd_ix_st_blob_read(SV *, imp_sth_t *, int, long, long, SV *, long);
extern int dbd_ix_st_execute(SV *, imp_sth_t *);
extern int dbd_ix_st_finish(SV *sth, imp_sth_t *imp_sth, int gd_flag);
extern int dbd_ix_st_prepare(SV *, imp_sth_t *, char *, SV *);
extern int dbd_ix_st_rows(SV *, imp_sth_t *);
extern void dbd_ix_st_destroy(SV *, imp_sth_t *);

/* Other non-standard entry points */
extern void dbd_ix_enter(const char *function);
extern void dbd_ix_exit(const char *function);

#endif /* DBDIMP_H */
