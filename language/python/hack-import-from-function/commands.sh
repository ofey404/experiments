#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python basic.py 
# os.extrakey not found

python in-file-patch.py 
# os.extrakey = extravalue

python import-no-such-package.py 
# no_such_package not found

