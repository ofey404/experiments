#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# == Don't use apt to install google-perftools ==
# sudo apt-get install google-perftools libgoogle-perftools-dev
# ls /usr/lib/libprofiler.so
# ls: cannot access '/usr/lib/libprofiler.so': No such file or directory

# == use vcpkg instead ==
vcpkg install gperftools libunwind

make -C cmake-build-debug/
./cmake-build-debug/main_perf
# PROFILE: interrupts/evictions/bytes = 410/49/10584
ls
# CMakeLists.txt  cmake-build-debug  commands.sh  main.cpp  my_profiler.log

go install github.com/google/pprof@latest

pprof ./cmake-build-debug/main_perf my_profiler.log
# in pprof
# pdf > output.pdf
