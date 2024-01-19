#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# untar commands
tar -xvf  file.tar
tar -xvzf file.tar.gz
tar -xvjf file.tar.bz2
tar -xvJf file.tar.xz
