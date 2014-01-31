#!/bin/sh

set -e

# create directories and files
mkdir ca req key cert
touch ca/index.txt
echo 01 > ca/serial

# Generate Key and root CA Certificate
openssl req -x509 -newkey rsa:4096 -config openssl.cnf -keyout ca/lernstick_uefi_ca.key -out ca/lernstick_uefi_ca.crt -days 3652

# Convert to DER format
openssl x509 -in ca/lernstick_uefi_ca.crt -outform der -out ca/lernstick_uefi_ca.der

# Show certificat
openssl x509 -in ca/lernstick_uefi_ca.crt -text
