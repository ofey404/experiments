#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# or
./build.sh
docker run -it --rm -p 8888:8888 hellokv:latest

curl -X GET -i "localhost:8888/getkey" \
-H "Content-Type: application/json" \
-d '{ "key": "key1" }'
# key not found

curl -X POST -i "localhost:8888/setkey" \
-H "Content-Type: application/json" \
-d '{ "key": "key1", "value": "value1" }'
# 200 OK
