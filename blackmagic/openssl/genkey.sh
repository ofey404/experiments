#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo "Generating keypair to $(pwd)"

echo "Store the private key as $(pwd)/private_key.pem"
openssl genpkey -algorithm RSA -out private_key.pem

echo "Store the public key as $(pwd)/public_key.pem"
openssl rsa -in private_key.pem -pubout -out public_key.pem
