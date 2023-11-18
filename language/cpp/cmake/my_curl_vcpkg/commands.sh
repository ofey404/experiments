#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This is a vcpkg version of ../my_curl

# Install vcpkg
sudo apt-get install build-essential tar curl zip unzip pkg-config
cd ~
git clone https://github.com/microsoft/vcpkg
./vcpkg/bootstrap-vcpkg.sh
export PATH=$PATH:$HOME/vcpkg
vcpkg version
# vcpkg package management program version 2023-10-18-27de5b69dac4b6fe8259d283cd4011e6d20a84ce

vcpkg integrate install
# Applied user-wide integration for this vcpkg root.
# CMake projects should use: "-DCMAKE_TOOLCHAIN_FILE=/home/ofey/vcpkg/scripts/buildsystems/vcpkg.cmake"

#####################################################################
# dependencies
#####################################################################

# Option 1: manually install
vcpkg install curl
vcpkg install gtest

# Option 2: use vcpkg.json
vcpkg install

