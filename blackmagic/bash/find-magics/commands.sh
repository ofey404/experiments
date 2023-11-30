#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# find file larger than 100K
find . -type f -size +100k -exec ls -lhS {} \;

# find file modified in 30 days
find . -name '*.go' -mtime -30
