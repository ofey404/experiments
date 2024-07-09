#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# get 10 most recent directories
git log -10 --name-only --pretty=format: | grep -E 'commands.sh|package.json' | xargs -I {} dirname {} | sort -u
