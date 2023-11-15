#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python server.py 
python client.py 
# File uploaded successfully
# 127.0.0.1 - - [14/Nov/2023 15:08:58] "POST /upload HTTP/1.1" 200 -
