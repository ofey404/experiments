#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This CLI utility uses urfave/cli package
# https://cli.urfave.org/v2/getting-started/
go run .
go build -o generator

./generator --jwk jwk.json
# JwkFilePath "jwk.json"
# ## Buffer:
# {
#   "aud": [
#     "Golang Users"
#   ],
#   "iat": 500,
#   "iss": "ofey404@test.com",
#   "sub": "ofey404"
# }
# ## Signed key
# eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiR29sYW5nIFVzZXJzIl0sImlhdCI6NTAwLCJpc3MiOiJvZmV5NDA0QHRlc3QuY29tIiwic3ViIjoib2ZleTQwNCJ9.i3Es4awDM5nmQsjgVewgTjEFRCq4BnsaX6bkNK2yzAuDCwEFshxpiwlBD4b20CbOX0ncxGKyD8iL2VRij4w3vkdBsGYWC3pEGc6J2lTP6FwChYq5eW1MunlSO0KzyWJIGMLeeGNV0RW81WVBMnTmofTXFf6pq4K1FrEbZK40Prk
