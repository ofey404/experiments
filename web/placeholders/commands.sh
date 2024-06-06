#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# For diagrams:
#
# https://via.placeholder.com/1920x1080


# API:
#
# https://jsonplaceholder.typicode.com/

curl https://jsonplaceholder.typicode.com/todos/1
# {
#   "userId": 1,
#   "id": 1,
#   "title": "delectus aut autem",
#   "completed": false
# }