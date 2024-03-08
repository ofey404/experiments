#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# TO BE CONTINUED

# Non blocking algorithm
# https://en.wikipedia.org/wiki/Non-blocking_algorithm#:~:text=A%20lock%2Dfree%20data%20structure,be%20serialized%20to%20stay%20coherent.


# Some golang implementations:
# https://github.com/dustinxie/lockfree
# https://github.com/cornelk/hashmap (Better, with generic support)


# A fruitful Hacker News thread:
# Designing a Lock-free, Wait-free Hash Map (shlomisteinberg.com)
# https://news.ycombinator.com/item?id=15768809
# https://shlomisteinberg.com/2015/09/28/designing-a-lock-free-wait-free-hash-map/

