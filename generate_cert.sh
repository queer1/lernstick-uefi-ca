#!/bin/sh

set -e

if [ -z "$1" ] ; then
  echo "Usage: $0 basename"
  exit 1
fi

BASENAME="$1"

error="false"
for f in key/${BASENAME}.key \
         req/${BASENAME}.csr \
         cert/${BASENAME}.crt \
         cert/${BASENAME}.der
do
  if [ -e "${f}" ] ; then
    echo "ERROR: File ${f} exists."
    error="true"
  fi
done

if [ "${error}" = "true" ] ; then
  exit 1
fi

# Generate a new key and signing request
openssl req -newkey rsa:2048 -out req/${BASENAME}.csr -keyout key/${BASENAME}.key -config openssl.cnf

# Sign the request with our CA
openssl ca -in req/${BASENAME}.csr -out cert/${BASENAME}.crt -config openssl.cnf

