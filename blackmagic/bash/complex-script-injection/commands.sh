#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#####################################################################
# 1. Inject authorized_keys and skip duplication
#####################################################################

cd 1-skip-dupe-authkey/

./merge_keys.sh 
# .../skip-dupe-authkey/authorized_keys exists, merge them
cat authorized_keys_merged 
# key1
# key2
# key3

cd -

#####################################################################
# 2. Update specified section of bashrc
#####################################################################

cd 2-update-bashrc-section/

cd -
