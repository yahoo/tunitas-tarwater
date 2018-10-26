# usage: source ${0%/*}/rigging.sh || exit 70
if ((0 == ${UID:-0})) ; then
    echo "Error: ${0%.test} cannot be run as root (that would be foolishness)"
    exit 70
fi 1>&2 
#
# WATCHOUT - PWD is either
# is either /build/tunitas/tarwater/tests/uss
# or else   /build/tunitas/tarwater
#
if [ -d ./bin ] ; then
    topdir=.
elif [ -d ../../bin ] ; then
    topdir=../..
else
    echo "Error: cannot figure out topdir from $(pwd)"
    exit 70
fi 1>&2
# Question: lib? or libexec?
# Answer:  Either, but not both, per http://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html
export PATH="${topdir?}/bin:${topdir?}/lib/tunitas-tarwater:${topdir?}/libexec/tunitas-tarwater:$PATH"
# also works if $0 is ./something.test
exe=$(cd ${0%/*} && pwd); exe=${exe##*/}
if ! type -p ${exe?} >& /dev/null ; then
    echo "Error: cannot find the executable ${exe?} in PATH=$PATH"
fi 1>&2
