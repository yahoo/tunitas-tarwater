#!/bin/sh
# Adapted from the fragment cited in the Java eample
: ${NAME:=t99} # or maybe NAME=example
private=${NAME?}.private
public=${NAME?}.public
set -e
openssl genrsa -out $private.pem 2048
openssl rsa -in $private.pem -outform PEM -pubout -out $public.pem
openssl pkcs8 -topk8 -nocrypt -in $private.pem -outform DER -out $private.der
openssl rsa -in $private.pem -pubout -outform DER -out $public.der
