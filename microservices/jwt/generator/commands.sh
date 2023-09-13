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
