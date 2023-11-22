#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# func 2 intend to run forever
# func 2 intend to run forever
# func 2 intend to run forever
# func 2 intend to run forever
# ...
# func 2 intend to run forever
# func 2 intend to run forever
# func 2 intend to run forever
# func 1
# func 1 closed
# but as func 1 closed, the main process would shut down
