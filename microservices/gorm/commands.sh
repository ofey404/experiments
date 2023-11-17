#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/go-gorm/gorm

cd basic/
    go run .
    # Then check test.sqlite
cd -


cd uuid-primary-key/
    go run .
    # Then check test.sqlite
cd -



