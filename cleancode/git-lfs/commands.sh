#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Installation
# https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage

sudo apt install git-lfs

mkdir -p /tmp/git-lfs
cd /tmp/git-lfs
