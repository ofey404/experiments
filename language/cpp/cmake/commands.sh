#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

vcpkg integrate install
# Applied user-wide integration for this vcpkg root.
# CMake projects should use: "-DCMAKE_TOOLCHAIN_FILE=/home/ofey/vcpkg/scripts/buildsystems/vcpkg.cmake"

make -C cmake-build-debug/
./cmake-build-debug/main
