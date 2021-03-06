AC_PREREQ(2.50)
AC_INIT(pure-db, 2.1)
AM_INIT_AUTOMAKE
AC_CONFIG_SRCDIR(src/puredb_read.c)
AM_CONFIG_HEADER(config.h)

AC_SUBST(VERSION)

ISODATE=`date +%Y-%m-%d`
AC_SUBST(ISODATE)

dnl Checks for programs.
AC_PROG_INSTALL
AC_PROG_CC
AC_AIX
AC_ISC_POSIX
AC_PROG_CC_STDC
AM_PROG_LIBTOOL
CFLAGS="$CFLAGS -D_GNU_SOURCE=1"

AC_HEADER_STDC
AC_HEADER_STAT
AC_CHECK_HEADERS(unistd.h sys/param.h ioctl.h sys/ioctl.h string.h strings.h)
AC_CHECK_HEADERS(netinet/in_systm.h netinet/in.h)
AC_CHECK_HEADERS(fcntl.h sys/fcntl.h)
AC_CHECK_HEADERS(windows.h io.h)

dnl Checks for types
AC_TYPE_SIZE_T
AC_TYPE_OFF_T
AC_TYPE_MODE_T

dnl Compiler characteristics
AC_PROG_GCC_TRADITIONAL
AC_C_CONST
AC_C_INLINE

dnl Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_ALLOCA
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_CHECK_FUNCS(memset munmap strdup fileno mapviewoffile)

dnl Options
AC_ARG_WITH(minimal,
[AC_HELP_STRING([--with-minimal],[Optimize for size, not for speed])],
[ if test "x$withval" = "xyes" ; then
    AC_DEFINE(MINIMAL,,[with minimal])
  fi ])

AC_CONFIG_FILES(Makefile src/Makefile)

AC_OUTPUT

