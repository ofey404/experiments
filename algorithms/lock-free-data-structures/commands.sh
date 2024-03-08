#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Non blocking algorithm
# https://en.wikipedia.org/wiki/Non-blocking_algorithm#:~:text=A%20lock%2Dfree%20data%20structure,be%20serialized%20to%20stay%20coherent.


