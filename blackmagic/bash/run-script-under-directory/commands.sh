#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

./entry.sh 
# /home/ofey/cloud-workspace/experiments/blackmagic/bash/run-script-under-directory/scripts/1.sh
# /home/ofey/cloud-workspace/experiments/blackmagic/bash/run-script-under-directory/scripts/2.sh
# $OPTIONAL_SCRIPT_DIR is not set

OPTIONAL_SCRIPT_DIR=1 ./entry.sh 
# /home/ofey/cloud-workspace/experiments/blackmagic/bash/run-script-under-directory/scripts/1.sh
# /home/ofey/cloud-workspace/experiments/blackmagic/bash/run-script-under-directory/scripts/2.sh
# $OPTIONAL_SCRIPT_DIR is set as 1
# Directory 1 does not exist, exiting...

OPTIONAL_SCRIPT_DIR=scripts-optional ./entry.sh 
# /home/ofey/cloud-workspace/experiments/blackmagic/bash/run-script-under-directory/scripts/1.sh
# /home/ofey/cloud-workspace/experiments/blackmagic/bash/run-script-under-directory/scripts/2.sh
# $OPTIONAL_SCRIPT_DIR is set as scripts-optional
# scripts-optional/1.sh
# scripts-optional/2.sh