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
cp output/public_key.pem app/public_key.pem

# 2. sign a license for it
go run issuer/main.go -private-key output/private_key.pem -o output/license.json
# loading private key from path: output/private_key.pem
# license dumped into output/license.json

# 3. build a app with public key
go run app/main.go -license output/license.json
# license data: {test@example.com 2024-12-10 18:03:59.858948372 +0800 CST}
