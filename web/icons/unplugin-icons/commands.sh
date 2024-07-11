#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/unplugin/unplugin-icons

# click `unplugin icons`
# https://icon-sets.iconify.design/
# https://icones.js.org/

npm i -D unplugin-icons @iconify/json

# TO BE CONTINUED
# use nextjs. it seems not compatible with pure react (no vite)
