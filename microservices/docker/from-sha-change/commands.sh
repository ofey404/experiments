#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

docker pull nginx:latest
docker image inspect nginx:latest > original.json

docker build -t nginx:inspect-from-sha-change .
docker image inspect nginx:inspect-from-sha-change > modified.json

# see diff with command line
diff --unified original.json modified.json > diff.txt

# or see diff in vscode
code --diff original.json modified.json
