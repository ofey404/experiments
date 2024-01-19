#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# transfer file via HTTP
python -m http.server

# receive
cd /tmp
curl -O http://localhost:8000/commands.sh
cat /tmp/commands.sh
# file content...
