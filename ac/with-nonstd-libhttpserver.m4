dnl This is -*- m4 -*- to be consumed by configure.ac
dnl Copyright 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-tarwater/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/services/tarwater/tree/LICENSE
dnl
dnl WITH_NONSTD_LIBHTTPSERVER
dnl
dnl Inputs
dnl
dnl   --with-nonstd-libhttpserver=PREFIX
dnl
dnl Defaults
dnl
dnl   'yes' defaults PREFIX to /opt/nonstd/libhttpserver
dnl   'no'  the non-standard httpserver will not be used
dnl
dnl Postcondition
dnl
dnl   If selected, then the related variables are defined
dnl   nonstd_libhttpserver_prefix
dnl   nonstd_libhttpserver_includedir
dnl   nonstd_libhttpserver_libdir
dnl   nonstd_libhttpserver_CPPFLAGS
dnl   nonstd_libhttpserver_CXXFLAGS
dnl   nonstd_libhttpserver_LDFLAGS
dnl
dnl WATCHOUT - the "standard build" of libhttpserver is not tested with IPv6 and does not work.
dnl Observed 2018-Q2 on Fedora 27 with libhttpserver-devel-0.9.0-3.fc24.x86_64
dnl See the patches nearby.
dnl
AC_DEFUN([WITH_NONSTD_LIBHTTPSERVER], [
    AC_ARG_WITH([with-nonstd-httpserver],
                AS_HELP_STRING([--with-nonstd-httpserver]. [ERROR, use --with-nonstd-libhttpserver instead, the pesky "lib" prefix]),
                [
                    AC_MSG_NOTICE([watch out for that pesky "lib" prefix on the package of the library])
                    AC_MSG_NOTICE([there is no --with-nonstd-httpserver=$withval])
                    AC_MSG_NOTICE([use --with-nonstd-libhttpserver=${withval} instead])
                    AC_MSG_ERROR([cannot continue])
                ])
    _lib=$(if test -e /lib64 ; then echo lib64; else echo lib; fi)
    AC_ARG_WITH([nonstd-libhttpserver],
                AS_HELP_STRING([--without-nonstd-libhttpserver]. [Without the patched libhttpserver]),
                [
                    case $withval in
                    ( yes ) nonstd_libhttpserver_prefix=/opt/nonstd/libhttpserver ;;
                    ( no ) unset nonstd_libhttpserver_prefix ;;
                    ( * )
                        if ! test -d ${withval?} || ! test -d ${withval?}/include || ! test -d ${withval?}/${_lib?}
                        then
                            AC_MSG_NOTICE([invalid directory for --with-nonstd-libhttpserver])
                            AC_MSG_ERROR([the directory ${withval?} does not exist])
                        fi
                        nonstd_libhttpserver_prefix=$withval
                        ;;
                    esac
                ],
                [
                    AC_MSG_NOTICE([whereas libhttpserver-0.9.0 and prior has showstopper bugs on IPv6 operations])
                    AC_MSG_NOTICE([suggest --with-nonstd-libhttpserver and (rpm) package nonstd-libhttpserver-devel])
                    AC_MSG_ERROR([an explict choice of --with or --without is required for nonstd-libhttpserver])
                ])
    if test -n "${nonstd_libhttpserver_prefix}"
    then
        AC_MSG_NOTICE([using the non-standard libhttpserver at ${nonstd_libhttpserver_prefix?}])
        nonstd_libhttpserver_includedir=${nonstd_libhttpserver_prefix:+$nonstd_libhttpserver_prefix/include}
        nonstd_libhttpserver_libdir=${nonstd_libhttpserver_prefix:+$nonstd_libhttpserver_prefix/${_lib?}}
        nonstd_libhttpserver_CPPFLAGS="${nonstd_libhttpserver_includedir:+-I$nonstd_libhttpserver_includedir}"
        nonstd_libhttpserver_CXXFLAGS=
        nonstd_libhttpserver_LDFLAGS=${nonstd_libhttpserver_libdir:+-L$nonstd_libhttpserver_libdir -Wl,-rpath=$nonstd_libhttpserver_libdir}
    fi
    AC_SUBST([nonstd_libhttpserver_prefix])
    AC_SUBST([nonstd_libhttpserver_includedir])
    AC_SUBST([nonstd_libhttpserver_libdir])
    AC_SUBST([nonstd_libhttpserver_CPPFLAGS])
    AC_SUBST([nonstd_libhttpserver_CXXFLAGS])
    AC_SUBST([nonstd_libhttpserver_LDFLAGS])
])

dnl Absent this patch, the libhttpserver will come up on IPv6
dnl but will disrespect the port chosen in Create_Webserver (another arbitrary port will be used)
dnl
dnl Exhibition (but you should get the real patches or the pull request)
dnl
dnl diff --git a/configure.ac b/configure.ac
dnl index 2f399e8..2938b9c 100644
dnl --- a/configure.ac
dnl +++ b/configure.ac
dnl @@ -139,7 +139,13 @@ AC_SUBST(COND_GCOV)
dnl  
dnl  if test x"have_gnutls" = x"yes"; then
dnl      AM_CXXFLAGS="$AM_CXXFLAGS -DHAVE_GNUTLS"
dnl -    AM_CFLAGS="$AM_CXXFLAGS -DHAVE_GNUTLS"
dnl +    AM_CFLAGS="$AM_CFLAGS -DHAVE_GNUTLS"
dnl +fi
dnl +# Of course you have IPv6.
dnl +have_inet6=yes
dnl +if test x"$have_inet6" = x"yes"; then
dnl +    AM_CXXFLAGS="$AM_CXXFLAGS -DHAVE_INET6"
dnl +    AM_CFLAGS="$AM_CFLAGS -DHAVE_INET6"
dnl  fi
dnl  
dnl  DX_HTML_FEATURE(ON)
dnl diff --git a/src/webserver.cpp b/src/webserver.cpp
dnl index d1a3c93..0c369af 100644
dnl --- a/src/webserver.cpp
dnl +++ b/src/webserver.cpp
dnl @@ -467,14 +467,14 @@ bool webserver::start(bool blocking)
dnl              const struct sockaddr *servaddr = NULL;
dnl              socklen_t addrlen;
dnl  #if HAVE_INET6
dnl -            if (0 != (options & MHD_USE_IPv6))
dnl +            if(use_ipv6)
dnl                  addrlen = sizeof (struct sockaddr_in6);
dnl              else
dnl  #endif
dnl                  addrlen = sizeof (struct ::sockaddr_in);
dnl  
dnl  #if HAVE_INET6
dnl -            if (0 != (options & MHD_USE_IPv6))
dnl +            if(use_ipv6)
dnl              {
dnl                memset (&servaddr6, 0, sizeof (struct sockaddr_in6));
dnl                servaddr6.sin6_family = AF_INET6;
dnl
