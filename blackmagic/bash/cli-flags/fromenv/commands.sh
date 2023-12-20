#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

./script.sh 
# Usage: FLAG_1={val1} FLAG_2={val2} ./script.sh

FLAG_1=val1 FLAG_2=val2 ./script.sh
# FLAG_1 = val1
# FLAG_2 = val2
