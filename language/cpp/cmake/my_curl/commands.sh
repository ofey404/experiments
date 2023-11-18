#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# manually install packages
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libgtest-dev

# Or use clion
mkdir cmake-build-debug
cd cmake-build-debug
cmake ..
make
