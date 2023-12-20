#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

./script.sh -f file -n name
# Flag -f is set with value: file
# Flag -n is set with value: name
# -f = file
# -n = name

# script would return if options are invalid

./script.sh -f
# ./script.sh: option requires an argument -- f

./script.sh -s
# ./script.sh: illegal option -- s