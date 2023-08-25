#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# start oidc op server
# oidc discovery http://localhost:9998/.well-known/openid-configuration
go run github.com/zitadel/oidc/v2/example/server
# start oidc web client (in a new terminal)
CLIENT_ID=web CLIENT_SECRET=secret ISSUER=http://localhost:9998/ SCOPES="openid profile" PORT=9999 go run github.com/zitadel/oidc/v2/example/client/app