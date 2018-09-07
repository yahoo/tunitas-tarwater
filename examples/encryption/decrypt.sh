#!/bin/sh
# adapted from https://github.com/digi-trust/dt-cdn/wiki/ID-encryption
function older_openssl() { : untested ... how old? ; false; }
: ${NAME:=example} # we will be reading this key system, not writing it.
private=${NAME?}.private
public=${NAME?}.public
cat ${1:-id-encrypted-base64.txt} | base64 --decode | if older_openssl ; then
    openssl rsautl -inkey $private.pem -oaep -decrypt
else
    openssl pkeyutl -decrypt -inkey $private.pem -pkeyopt rsa_padding_mode:oaep
fi

