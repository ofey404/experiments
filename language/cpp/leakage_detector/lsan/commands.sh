#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

make -C cmake-build-debug/

./cmake-build-debug/lsan
# nothing happened

./cmake-build-debug/lsan_debug
# =================================================================
# ==40470==ERROR: LeakSanitizer: detected memory leaks
#
# Direct leak of 10 byte(s) in 1 object(s) allocated from:
#     #0 0x7f83a2130302 in __interceptor_malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
#     #1 0x55c5c258115e in main /home/ofey/experiments/language/cpp/cmake/leakage_detector/lsan/main.cpp:4
#     #2 0x7f83a1bead8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
#
# SUMMARY: LeakSanitizer: 10 byte(s) leaked in 1 allocation(s).
