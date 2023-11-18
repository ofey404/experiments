#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# ofey404: old and bulky, requires seperate run.
#          I prefer lsan & asan.

sudo apt install valgrind

valgrind --leak-check=yes ./cmake-build-debug/leaky
# ==35729== Memcheck, a memory error detector
# ==35729== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
# ==35729== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
# ==35729== Command: ./cmake-build-debug/leaky
# ==35729==
# Memory allocated but not freed!
# ==35729==
# ==35729== HEAP SUMMARY:
# ==35729==     in use at exit: 100 bytes in 1 blocks
# ==35729==   total heap usage: 3 allocs, 2 frees, 73,828 bytes allocated
# ==35729==
# ==35729== 100 bytes in 1 blocks are definitely lost in loss record 1 of 1
# ==35729==    at 0x484A2F3: operator new[](unsigned long) (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
# ==35729==    by 0x1091BE: main (main.cpp:4)
# ==35729==
# ==35729== LEAK SUMMARY:
# ==35729==    definitely lost: 100 bytes in 1 blocks
# ==35729==    indirectly lost: 0 bytes in 0 blocks
# ==35729==      possibly lost: 0 bytes in 0 blocks
# ==35729==    still reachable: 0 bytes in 0 blocks
# ==35729==         suppressed: 0 bytes in 0 blocks
# ==35729==
# ==35729== For lists of detected and suppressed errors, rerun with: -s
# ==35729== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)
