# This is a GNU -*- Makefile -*- fragment that is included by Automake
# Copyright Yahoo Inc, 2021.
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-tarwater/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/services/tarwater/tree/LICENSE

ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
default:
include tests/Makefrag.am
include @temerarious_flagship_datadir@/am/build.am

# WATCHOUT - if you utter 'clean' then that becomes the clean rule; automake won't synthesize one
# therefore, only mention 'clean-local'
clean-local:: clean-dependencies
default: all

# These MUST match with TF_WITH_MODULE in configure.ac
DEVELOPMENT_AREAS = \
  $(module_cli_core_prefix) \
  $(module_crypto_prefix) \
  $(module_json_prefix) \
  $(module_langu_prefix) \
  $(module_nonstd_prefix) \
  $(module_sys_prefix) \
  $(microhttpd___prefix) \
  $(tunitas_basics_prefix) \
  $(deprecated_DEVELOPMENT_AREAS) \
  $(end)
TESTING_AREAS = \
  $(module_rigging_app_prefix) \
  $(module_rigging_core_prefix) \
  $(deprecated_TESTING_AREAS) \
  $(end)
INSTALLATION_AREAS = \
  $(nonstd_gcc_prefix) \
  $(std_scold_prefix) \
  $(std_tunitas_prefix) \
  $(deprecated_INSTALLATION_AREAS) \
  $(end)

# There is no point in defining systemddir to follow $(prefix) because
# the system's systemd won't look in odd places, e.g. /usr/local/lib/systemd/system
systemddir = /usr/lib/systemd
systemd_systemdir = $(systemddir)/system
systemd_system_DATA = systemd/tarwater.service

bin_PROGRAMS = bin/tarwater-secret-dump bin/tarwater-secret-make
sbin_PROGRAMS = sbin/tarwater-service
lib_LTLIBRARIES = lib/libtunitas-tarwater.la
noinst_LTLIBRARIES = \
  noinst/lib/libautotools-autoconf+tunitas-tarwater.la \
  noinst/lib/libtunitas-tarwater.la \
  noinst/lib/libapp-service.la \
  noinst/lib/libapp-secret-dump.la \
  noinst/lib/libapp-secret-make.la \
  noinst/lib/libapp.la \
  noinst/lib/libwant.la \
  $(end)
check_PROGRAMS = check/bin/unit
check_LTLIBRARIES = 

include bin/tarwater-secret-dump.am
include bin/tarwater-secret-make.am
include check/bin/unit.am
include lib/libtunitas-tarwater.am
include noinst/lib/libapp.am
include noinst/lib/libapp-secret-dump.am
include noinst/lib/libapp-secret-make.am
include noinst/lib/libapp-service.am
include noinst/lib/libautotools-autoconf+tunitas-tarwater.am
include noinst/lib/libtunitas-tarwater.am
include noinst/lib/libwant.am
include sbin/tarwater-service.am

# --- Mostly boilerplate beyond here
#
# -Wall      ... the language isn't complete without it
# -std=c++1y ... as close to C++14 and beyond as we can get
# -std=c++1z ... as close to C++17 and beyond as we can get
# -std=c++2a ... as close to C++20 and beyond as we can get
# -std=c++2b ... as close to C++23 and beyond as we can get
# -std=c++2c ... as close to C++26 and beyond as we can get
# -ggdb      ... and recall that -ggdb and -O2 don't play well together

Makefile_COMPILER_CPPFLAGS_SET =       @CPPFLAGS_gcc@ @CPPFLAGS_gdb@
Makefile_COMPILER_CFLAGS_SET   = -Wall   @CFLAGS_gcc@   @CFLAGS_gdb@
Makefile_COMPILER_CXXFLAGS_SET = -Wall @CXXFLAGS_gcc@ @CXXFLAGS_gdb@
Makefile_COMPILER_LDFLAGS_SET  = -Wall  @LDFLAGS_gcc@  @LDFLAGS_gdb@

# configure.ac: TF_WITH_NONSTD([something-something])
Makefile_nonstd_PACKAGE_CPPFLAGS_SET = 
Makefile_nonstd_PACKAGE_CFLAGS_SET   = 
Makefile_nonstd_PACKAGE_CXXFLAGS_SET = 
Makefile_nonstd_PACKAGE_LDFLAGS_SET  = 

Makefile_PACKAGE_CPPFLAGS_SET = 
Makefile_PACKAGE_CFLAGS_SET   = 
Makefile_PACKAGE_CXXFLAGS_SET = 
Makefile_PACKAGE_LDFLAGS_SET  = 

Makefile_nonstd_CHECK_CPPFLAGS_SET = 
Makefile_nonstd_CHECK_CFLAGS_SET   = 
Makefile_nonstd_CHECK_CXXFLAGS_SET = 
Makefile_nonstd_CHECK_LDFLAGS_SET  = 

#                                                  if    did not substitute away                      then use this
#                                                  |           |                                      |            else use the substitution
#                                                  |           |              @CPPFLAGS_no_install@   |            |
#                                                  |           |              |                       |            |
#                                                  |           |              |                       |            |
#                                                  v           v              v                       v            v
Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_cppunit@ $(if $(filter %_no_install@, @CPPFLAGS_no_install@), $(empty),    @CPPFLAGS_no_install@)
Makefile_CHECK_CFLAGS_SET   =   @CFLAGS_cppunit@ $(if $(filter %_no_install@, @CFLAGS_no_install@),   $(empty),    @CFLAGS_no_install@)
Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_cppunit@ $(if $(filter %_no_install@, @CXXFLAGS_no_install@), $(empty),    @CXXFLAGS_no_install@)
Makefile_CHECK_LDFLAGS_SET  =  @LDFLAGS_cppunit@ $(if $(filter %_no_install@, @LDFLAGS_no_install@),  -no-install, @LDFLAGS_no_install@)

# These are assembled by .../toolflags.mk in hypogal-twilight >= 0.45.0
AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
AM_LDFLAGS  = $(PACKAGE_LDFLAGS_SET) $(V_LDFLAGS_avoid.VERBOSE_Veq$(V))
AM_LIBTOOLFLAGS = $(V_LIBTOOLFLAGS_VERBOSE_Veq$(V))

deprecated_DEVELOPMENT_AREAS = \
  $(module_cli_prefix) \
  $(module_ip_prefix) \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_std_prefix) \
  $(module_string_prefix) \
  $(end)
deprecated_TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
deprecated_INSTALLATION_AREAS = \
  $(nonstd_cppunit_prefix) \
  $(end)
