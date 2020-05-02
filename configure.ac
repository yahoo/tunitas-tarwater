dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-tarwater/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/services/tarwater/tree/LICENSE
dnl
dnl Build Instructions are in the nearby README.md
dnl
dnl ./maintenance/nearby is a developer-centric build recipe; it guesses about nearby source trees
dnl
dnl ./buildconf &&
dnl ./configure --prefix=/opt/tunitas &&
dnl make &&
dnl make check &&
dnl make install &&
dnl echo OK DONE
dnl
AC_INIT([tarwater], [0.1.0], [tunitas@verizonmedia.com])
TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

dnl These options are also in the Makefile.am in AUTOMAKE_OPTIONS
dnl AM_INIT_AUTOMAKE([no-define subdir-objects foreign])
AM_SILENT_RULES([yes])

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile systemd/tarwater.service])
#
# To have submodules
#   configure.ac: TF_CONFIG_SUBMODULES([submodules], [...list...])
#   Makefile.am:  SUBDIRS = @subdirs@
# to have no submodules
#   comment these schemes out in both files
#

TF_COMPONENT_METADIRECTORY_TIERS
TF_ENABLE_GNU
TF_ENABLE_GDB
TF_ENABLE_GCC
TF_ENABLE_LIBTOOL_NO_INSTALL
TF_ENABLE_MOCK_BUILD dnl [[deprecating]] but creates mk/configured.mk and nothing else (yet) does that

TF_WITH_STD([scold])
TF_WITH_STD([tunitas])

TF_WITH_SUBSYSTEM([temerarious-flagship], [], [The Tunitas Build System])
TF_WITH_SUBSYSTEM([tunitas-basics], [], [The Tunitas Basics])

# and mention in $(DEVELOPMENT_AREAS) in Makefile.am
TF_WITH_MODULE([crypto])
TF_WITH_MODULE([httpserver])
TF_WITH_MODULE([json])
TF_WITH_MODULE([nonstd])
TF_WITH_MODULE([options])
TF_WITH_MODULE([posix])
TF_WITH_MODULE([std])
TF_WITH_MODULE([string]) dnl a.k.a. c-string
TF_WITH_MODULE([sys])

TF_WITH_MODULE([cppunit])
TF_WITH_MODULE([rigging]) dnl a.k.a. unit-rigging -> rigging-unit

TF_MSG_VERBOSE([compiler-specific (alphabetical)])
TF_WITH_NONSTD([cppunit])
TF_WITH_NONSTD([gcc]) dnl but modern gcc-7.1.0, gcc-8 & beyond is fine
TF_WITH_NONSTD([jsoncpp]) dnl but modern jsoncpp-1.8.4 is fine
TF_WITH_NONSTD([libhttpserver])

AC_CONFIG_SRCDIR([src/app/service/main.xcpp])
AM_PROG_AR
LT_PREREQ([2.4.2])
LT_INIT
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_C_O
TF_PROG_DC
TF_CHECK_CPPUNIT
TF_CHECK_JSONCPP

m4_include([ac/with-nonstd-libhttpserver.m4])
WITH_NONSTD_LIBHTTPSERVER

# module-httpserver-devel >= 0.5.0-0.devel contains httpserver.Service and httpserver.service.Create
TF_CHECK_PACKAGES([httpserver.Service httpserver.service.Create], [module-httpserver-devel])

dnl https://www.gnu.org/software/autoconf/manual/autoconf-2.66/html_node/Libraries.html
dnl https://www.gnu.org/software/gnulib/manual/html_node/Searching-for-Libraries.html
AC_CHECK_LIB([httpserver], [main]) 
AC_CHECK_LIB([microhttpd], [main]) 
AC_CHECK_LIB([gnutls], [main]) 
AC_CHECK_LIB([jsoncpp], [main]) 

m4_include([ac/with-pkgconfigdir.m4])
pkgconfdir='${prefix}/tunitas/tarwater'
AC_DEFINE_UNQUOTED([TUNITAS_TARWATER_PKGCONFDIR], ["$tunitas_tarwater_pkgconfdir"], [directory containing the configuration files, e.g. /etc/tunitas/tarwater])

TF_FINALIZE
