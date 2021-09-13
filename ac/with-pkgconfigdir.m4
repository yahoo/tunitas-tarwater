dnl This is -*- m4 -*- to be consumed by configure.ac
dnl Yahoo Inc. 2021
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-tarwater/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/services/tarwater/tree/LICENSE
dnl
dnl TARWATER_WITH_PKGCONFIGDIR     (no options)
dnl
dnl Inputs
dnl
dnl   --with-pkgconfigdir=DIRECTORY
dnl
dnl Defaults
dnl   
dnl   DIRECTORY defaults to /etc/tunitas/tarwater
dnl
dnl Postconditions
dnl
dnl   tunitas_tarwater_pkgconfigdir is set
dnl
dnl Expectations
dnl
dnl   tunitas_tarwater_pkgconfigdir is /etc/tunitas/tarwater
dnl
AC_DEFUN([TARWATER_WITH_PKGCONFIGDIR], [
    default_tunitas_tarwater_pkgconfigdir='${prefix}/tunitas/tarwater'
    AC_ARG_WITH([pkgconfigdir],
                AS_HELP_STRING([--with-pkgconfigdir]. [the package configuration directory]),
                [
                    case $withval in
                    ( yes ) tunitas_tarwater_pkgconfdir=$default_tunitas_tarwater_pkgconfigdir ;;
                    ( no )
                            AC_MSG_ERROR([the package configuration directory must be defined])
                    ( * )
                        if ! test -d ${withval?}
                        then
			    # but you might be configuring prior to building and installing
                            TF_MSG_WARNING([the directory ${withval?} does not exist])
                        fi
                        tunitas_tarwater_pkgconfigdir=$withval
                        ;;
                    esac
                ],
                [
                    tunitas_tarwater_pkgconfdir=$default_tunitas_tarwater_pkgconfigdir
                ])
    TF_MSG_VERBOSE([Using tunitas_tarwater_pkgconfdir as ${tunitas_tarwater_pkgconfdir:-empty}])
])
