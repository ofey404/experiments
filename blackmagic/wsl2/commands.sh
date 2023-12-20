#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# to open edge from wsl
export BROWSER='/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe'

# Access host port from WSL2
# See: https://superuser.com/questions/1679757/how-to-access-windows-localhost-from-wsl2
curl $(hostname).local:8000
