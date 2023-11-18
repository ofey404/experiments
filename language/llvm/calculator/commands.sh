#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

sudo apt-get install clang llvm

llvm-config --version
# 14.0.0
clang --version
# Ubuntu clang version 14.0.0-1ubuntu1.1
# Target: x86_64-pc-linux-gnu
# Thread model: posix
# InstalledDir: /usr/bin

# or
vcpkg install llvm
# it's so slow...

make -C cmake-build-debug/
./cmake-build-debug/CalculatorFrontend
# > 1+2
# i32 3
# > 2-1
# i32 1
