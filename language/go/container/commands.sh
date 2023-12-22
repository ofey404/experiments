#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run intheap.go 
# minimum: 1
# 1 2 3 5

go run priorityqueue.go 
# 05:orange 04:pear 03:banana 02:apple

go run list.go 
# 1
# 2
# 3
# 4

go run ring.go 
# # print all values of the ring, easy done with ring.Do()
# kenya
# guatemala
# ethiopia
# # .. or each one by one. print first 5 values
# guatemala
# ethiopia
# kenya
# guatemala
# ethiopia
