#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This directory illustrates a license encryption and decryption process.
#
# Partially refer to https://github.com/hyperboloide/lk, but replaced some
# obsolete functions.

# 1. create the pub-private keypair
mkdir -p output
openssl ecparam -genkey -name secp384r1 -noout -out output/private_key.pem
openssl ec -in output/private_key.pem -pubout -out output/public_key.pem

# 2. sign a license for it
go run issuer/main.go -private-key output/private_key.pem

# 3. build a app with public key
go run app/main.go -public-key ./output/public_key.pem
