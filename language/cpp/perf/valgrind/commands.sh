#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

make -C cmake-build-debug/
./cmake-build-debug/main

# slow. It takes minutes, even for this deadly simple program.
valgrind --tool=callgrind ./cmake-build-debug/main

sudo apt install kcachegrind  # version 4:21.12.3-0ubuntu1
kcachegrind callgrind.out.84028

# visualization
sudo apt-get install graphviz
pip install gprof2dot

gprof2dot -f callgrind callgrind.out.84028 > output.dot
dot -Tpdf output.dot -o output.pdf
