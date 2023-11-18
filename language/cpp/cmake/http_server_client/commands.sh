#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# vcpkg dependency
# python3 requires autoconf from the system package manager (example: "sudo apt-get install autoconf")
sudo apt-get install autoconf automake libtool m4 pkg-config autoconf-archive

vcpkg install boost
