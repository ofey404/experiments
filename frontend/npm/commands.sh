#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# change npm cache directory
# - NPM_CONFIG_CACHE also works
export npm_config_cache=/tmp/cache
cd ../the-road-to-react/hacker-stories/
npm install
# check the cache
ls /tmp/cache/
# _cacache  _logs  _update-notifier-last-checked
