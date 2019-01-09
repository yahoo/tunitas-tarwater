# This is a GNU -*- Makefile -*- which is managed by automake

default:
ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
include @temerarious_flagship_datadir@/am/build.am

DEVELOPMENT_AREAS = \
  @module_httpserver_prefix@ \
  @module_json_prefix@ \
  @module_nonstd_prefix@ \
  @module_options_prefix@ \
  @module_posix_prefix@ \
  @module_std_prefix@ \
  @module_string_prefix@ \
  @module_sys_prefix@ \
  @tunitas_basics_prefix@ \
  $(end)
TESTING_AREAS = \
  @module_cppunit_prefix@ \
  @module_rigging_prefix@ \
  $(end)
INSTALLATION_AREAS = \
  @nonstd_cppunit_prefix@ \
  @nonstd_gcc_prefix@ \
  @nonstd_libhttpserver_prefix@ \
  @std_scold_prefix@ \
  @std_tunitas_prefix@ \
  $(end)

bin_PROGRAMS = 
sbin_PROGRAMS = sbin/tarwater-service
lib_LTLIBRARIES = 
noinst_LTLIBRARIES = \
  lib/libtunitas-tarwater.la \
  lib/libapp-service.la \
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

include src/tunitas/tarwater/Makefrag.am
include src/app/service/Makefrag.am
include src/want/Makefrag.am
include src/tests/unit/Makefrag.am

MODULES = \
  $(lib_libtunitas_tarwater_la_MODULES) \
  $(lib_libwant_la_MODULES) \
  $(bin_unit_MODULES) \
  $(src_app_service_MODULES_SET) \
  $(end)
$(if $(MODULES),$(__ok),$(error NO MODULES))
OBJECTS = \
  $(lib_libtunitas_tarwater_la_OBJECTS) \
  $(lib_libwant_la_OBJECTS) \
  $(bin_unit_OBJECTS) \
  $(src_app_service_OBJECTS) \
  $(end)
$(if $(OBJECTS),$(__ok),$(error NO OBJECTS))

# All this does is make every object depend upon every module
# so any change makes everything recompile. You don't want that.
# 
# DO NOT ---> $(OBJECTS) : $(MODULES)

include tests/unit/Makefrag.am
include tests/service/Makefrag.am
TESTS = \
  $(tests_unit_TESTS) \
  $(tests_service_TESTS) \
  $(end)
XFAIL_TESTS = \
  $(tests_unit_XFAIL_TESTS) \
  $(tests_service_XFAIL_TESTS) \
  $(end)

__DC_SEARCHPATH = $(SEARCHPATH_EXTERNAL_MODULES)
__DC_LOADPATH   = $(LOADPATHPATH_EXTERNAL_MODULES)

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

Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_cppunit@
Makefile_CHECK_CFLAGS_SET   = @CFLAGS_cppunit@
Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_cppunit@
Makefile_CHECK_LDFLAGS_SET  = @LDFLAGS_cppunit@

# reminder: ${TOOL}FLAGS remains reserved to the command line; e.g. CPPFLAGS, CFLAGS, CXXFLAGS, LDFLAGS
PACKAGE_CPPFLAGS_SET = $(__DC_SEARCHPATH) $(Makefile_PACKAGE_CPPFLAGS_SET) $(Makefile_nonstd_PACKAGE_CPPFLAGS_SET) $(Makefile_COMPILER_CPPFLAGS_SET)
PACKAGE_CFLAGS_SET   =                    $(Makefile_PACKAGE_CFLAGS_SET)   $(Makefile_nonstd_PACKAGE_CFLAGS_SET)   $(Makefile_COMPILER_CFLAGS_SET)
PACKAGE_CXXFLAGS_SET =                    $(Makefile_PACKAGE_CXXFLAGS_SET) $(Makefile_nonstd_PACKAGE_CXXFLAGS_SET) $(Makefile_COMPILER_CXXFLAGS_SET)
PACKAGE_LDFLAGS_SET  = $(__DC_LOADPATH)   $(Makefile_PACKAGE_LDFLAGS_SET)  $(Makefile_nonstd_PACKAGE_LDFLAGS_SET)  $(Makefile_COMPILER_LDFLAGS_SET)

# Reminder: most of the 'CHECK_' series is incremental
#           it is appended to AM_{CPP,C,CXX}FLAGS
#
# Usage (in 'make check' code):
#
#     bin_unit_LDFLAGS = $(PACKAGE_LDFLAGS_SET) $(AND_CHECK_LDFLAGS_SET)
#     $(bin_unit_OBJECTS): AM_CPPFLAGS+=$(CHECK_CPPFLAGS_SET)
#     $(bin_unit_OBJECTS): AM_CXXFLAGS+=$(CHECK_CXXFLAGS_SET)
#
AND_CHECK_CPPFLAGS_SET = $(Makefile_CHECK_CPPFLAGS_SET) $(Makefile_nonstd_CHECK_CPPFLAGS_SET)
AND_CHECK_CFLAGS_SET   = $(Makefile_CHECK_CFLAGS_SET)   $(Makefile_nonstd_CHECK_CFLAGS_SET)  
AND_CHECK_CXXFLAGS_SET = $(Makefile_CHECK_CXXFLAGS_SET) $(Makefile_nonstd_CHECK_CXXFLAGS_SET)
AND_CHECK_LDFLAGS_SET  = $(Makefile_CHECK_LDFLAGS_SET)  $(Makefile_nonstd_CHECK_LDFLAGS_SET) 

CHECK_CPPFLAGS_SET = $(PACKAGE_CPPFLAGS_SET) $(AND_CHECK_CPPFLAGS_SET)
CHECK_CFLAGS_SET   = $(PACKAGE_CFLAGS_SET)   $(AND_CHECK_CFLAGS_SET)
CHECK_CXXFLAGS_SET = $(PACKAGE_CXXFLAGS_SET) $(AND_CHECK_CXXFLAGS_SET)
CHECK_LDFLAGS_SET  = $(PACKAGE_LDFLAGS_SET)  $(AND_CHECK_LDFLAGS_SET)

AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
AM_LDFLAGS  = $(PACKAGE_LDFLAGS_SET) $(V_LDFLAGS_avoid.VERBOSE_Veq$(V))
AM_LIBTOOLFLAGS = $(V_LIBTOOLFLAGS_VERBOSE_Veq$(V))

V_LIBTOOLFLAGS_VERBOSE_Veq0 = --silent
V_LIBTOOLFLAGS_VERBOSE_Veq1 = --verbose

# Whereas
#   AM_LDFLAGS is deprecating.
#   AM_LDFLAGS is variously used in automake theory.
# Do not use AM_LDFLAGS;
# though LDFLAGS remains reserved caller the top-level caller (of make).
#
# A catalog of the use of AM_LDFLAGS
# used by CXXLINK
#         which is used to make convenience libraries; e.g. libwant.la
#         this appears to be a leftover accident.
#         in this case there is libwant_la_LIBADD but no libwant_la_LDFLAGS
# NOT used by lib_lib${LIBRARY}_la_LINK, e.g. lib/libsomething.la
#             which is used to make final-link{ed,able} shared libraries.
# NOT used by bin_${PROGRAM}_LINK, e.g. bin/unit
#             which is used o make final-linked executables.
#
V_LDFLAGS_avoid.VERBOSE_Veq0 = $(empty)
V_LDFLAGS_avoid.VERBOSE_Veq1 = $(warning warning: $@, \
CXXLINK still uses the AM_LDFLAGS variable is which is deprecated,  instead, use \
$(subst .,_,$(subst -,_,$(@F)_LIBADD)) \
or if available, \
$(subst .,_,$(subst -,_,$(@F)_LDFLAGS)))

# WATCHOUT - if you utter 'clean' then that becomes the clean rule; automake won't synthesize one
# therefore, only mention 'clean-local'
clean-local:: clean-dependencies
default: all
