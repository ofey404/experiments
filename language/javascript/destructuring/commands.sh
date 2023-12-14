#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# From: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment

./array.js
# [a, b, ...rest] = [10, 20, 30, 40, 50];
# a = 10
# b = 20
# rest = 30,40,50

./struct.js
# # without destructuring:
# Robin Wieruch
#
# # destructuring:
# const { lastName, firstName } = user;
# swap the order doesn't matter
# firstName = Robin
# lastName = Wieruch
