#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

chmod u+s /path/to/script

# or
visudo
# Add this line:
# 
# ALL ALL=NOPASSWD: /path/to/script
sudo /path/to/script
