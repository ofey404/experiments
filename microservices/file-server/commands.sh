#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run go/main.go 
# 2023/10/02 15:43:53 Serving . on HTTP port: 8100
# 2023/10/02 15:44:05 mockAuthMiddleware is called, it can access the request, decide what to do

