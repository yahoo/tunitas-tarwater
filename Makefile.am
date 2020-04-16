# This is a GNU -*- Makefile -*- fragment that is included by Automake
# Copyright 2018-2019, Oath Inc.
# Licensed under the terms of the Apache-2.0 license.
# See the LICENSE file in https://github.com/yahoo/tunitas-tarwater/blob/master/LICENSE for terms.
#

default:
ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
include @temerarious_flagship_datadir@/am/build.am

# WATCHOUT - if you utter 'clean' then that becomes the clean rule; automake won't synthesize one
# therefore, only mention 'clean-local'
clean-local:: clean-dependencies
default: all

# These match with TF_WITH_MODULE in configure.ac
DEVELOPMENT_AREAS = \
  $(module_crypto_prefix) \
  $(module_httpserver_prefix) \
  $(module_json_prefix) \
  $(module_nonstd_prefix) \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_std_prefix) \
  $(module_string_prefix) \
  $(module_sys_prefix) \
  $(tunitas_basics_prefix) \
  $(end)
TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
INSTALLATION_AREAS = \
  $(nonstd_cppunit_prefix) \
  $(nonstd_gcc_prefix) \
  $(nonstd_libhttpserver_prefix) \
  $(std_scold_prefix) \
  $(std_tunitas_prefix) \
  $(end)

# There is no point in defining systemddir to follow $(prefix) because
# the system's systemd won't look in odd places, e.g. /usr/local/lib/systemd/system
systemddir = /usr/lib/systemd
systemd_systemdir = $(systemddir)/system
systemd_system_DATA = systemd/tarwater.service

bin_PROGRAMS = bin/tarwater-secret-dump bin/tarwater-secret-make
sbin_PROGRAMS = sbin/tarwater-service
lib_LTLIBRARIES = 
noinst_LTLIBRARIES = \
  lib/libautotools-autoconf.la \
  lib/libtunitas-tarwater.la \
  lib/libapp-service.la \
  lib/libapp.la \
  lib/libwant.la \
  $(end)
check_PROGRAMS = bin/unit
check_LTLIBRARIES = 

$(bin_PROGRAMS) : $(lib_LTLIBRARIES) $(noinst_LTLIBRARIES)
$(sbin_PROGRAMS) : $(lib_LTLIBRARIES) $(noinst_LTLIBRARIES)
$(lib_LTLIBRARIES) : $(noinst_LTLIBRARIES)
$(check_PROGRAMS) : $(bin_PROGRAMS) $(sbin_PROGRAMS)
$(check_PROGRAMS) : $(lib_LTLIBRARIES) $(noinst_LTLIBRARIES)
$(check_PROGRAMS) : $(check_LTLIBRARIES)

include src/app/Makefrag.am
include src/app/secret/Makefrag.am
include src/app/service/Makefrag.am
include src/autotools/autoconf/Makefrag.am
include src/tests/unit/Makefrag.am
include src/tunitas/tarwater/Makefrag.am
include src/want/Makefrag.am

# NO NEED ---> MODULES = \
# NO NEED --->   $(lib_libtunitas_tarwater_la_MODULES) \
# NO NEED --->   $(lib_libwant_la_MODULES) \
# NO NEED --->   $(bin_unit_MODULES) \
# NO NEED --->   $(src_app_service_MODULES_SET) \
# NO NEED --->   $(end)
# NO NEED ---> $(if $(MODULES),$(__ok),$(error NO MODULES))
# NO NEED ---> OBJECTS = \
# NO NEED --->   $(lib_libtunitas_tarwater_la_OBJECTS) \
# NO NEED --->   $(lib_libwant_la_OBJECTS) \
# NO NEED --->   $(bin_unit_OBJECTS) \
# NO NEED --->   $(src_app_service_OBJECTS) \
# NO NEED --->   $(end)
# NO NEED ---> $(if $(OBJECTS),$(__ok),$(error NO OBJECTS))
# NO NEED ---> 
#
# DO NOT ---> All this does is make every object depend upon every module
# DO NOT ---> so any change makes everything recompile. You don't want that.
# DO NOT --->  
# DO NOT ---> $(OBJECTS) : $(MODULES)

include tests/unit/Makefrag.am
include tests/service/Makefrag.am
include tests/dump/Makefrag.am
include tests/make/Makefrag.am
TESTS = \
  $(tests_unit_TESTS) \
  $(tests_service_TESTS) \
  $(tests_dump_TESTS) \
  $(tests_make_TESTS) \
  $(end)
XFAIL_TESTS = \
  $(tests_unit_XFAIL_TESTS) \
  $(tests_service_XFAIL_TESTS) \
  $(tests_dump_XFAIL_TESTS) \
  $(tests_make_XFAIL_TESTS) \
  $(end)

# --- Mostly boilerplate beyond here
#
# -Wall      ... the language isn't complete without it
# -std=c++1y ... as close to C++14 and beyond as we can get
# -std=c++1z ... as close to C++17 and beyond as we can get
# -ggdb      ... and recall that -ggdb and -O2 don't play well together

Makefile_COMPILER_CPPFLAGS_SET =
Makefile_COMPILER_CFLAGS_SET   = -Wall @CFLAGS_gcc@   @CFLAGS_gdb@
Makefile_COMPILER_CXXFLAGS_SET = -Wall @CXXFLAGS_gcc@ @CXXFLAGS_gdb@
Makefile_COMPILER_LDFLAGS_SET  = -Wall @LDFLAGS_gcc@  @LDFLAGS_gdb@

Makefile_nonstd_PACKAGE_CPPFLAGS_SET = @nonstd_libhttpserver_CPPFLAGS@
Makefile_nonstd_PACKAGE_CFLAGS_SET   = @nonstd_libhttpserver_CFLAGS@
Makefile_nonstd_PACKAGE_CXXFLAGS_SET = @nonstd_libhttpserver_CXXFLAGS@
Makefile_nonstd_PACKAGE_LDFLAGS_SET  = @nonstd_libhttpserver_LDFLAGS@

Makefile_PACKAGE_CPPFLAGS_SET = 
Makefile_PACKAGE_CFLAGS_SET   = 
Makefile_PACKAGE_CXXFLAGS_SET = 
Makefile_PACKAGE_LDFLAGS_SET  = 

Makefile_nonstd_CHECK_CPPFLAGS_SET = 
Makefile_nonstd_CHECK_CFLAGS_SET   = 
Makefile_nonstd_CHECK_CXXFLAGS_SET = 
Makefile_nonstd_CHECK_LDFLAGS_SET  = 

# The @LDFLAGS_no_install@ is from TF_ENABLE_LIBTOOL_NO_INSTALL in temerarious-flagship >= 1.9.0-0.devel
Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_cppunit@ @CPPFLAGS_no_install@
Makefile_CHECK_CFLAGS_SET   = @CFLAGS_cppunit@   @CFLAGS_no_install@
Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_cppunit@ @CXXFLAGS_no_install@
Makefile_CHECK_LDFLAGS_SET  = @LDFLAGS_cppunit@  @LDFLAGS_no_install@

# These are assembled by .../toolflags.mk in hypogal-twilight >= 0.45.0
AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
AM_LDFLAGS  = $(PACKAGE_LDFLAGS_SET) $(V_LDFLAGS_avoid.VERBOSE_Veq$(V))
AM_LIBTOOLFLAGS = $(V_LIBTOOLFLAGS_VERBOSE_Veq$(V))
