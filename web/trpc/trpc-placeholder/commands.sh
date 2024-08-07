#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://trpc.io/

# TODO: build an API equivilant to https://jsonplaceholder.typicode.com/
#       We can build only `user`. It's good for testing.
