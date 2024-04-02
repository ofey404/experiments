#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROJECT_ROOT="$SCRIPT_DIR/.."

cd $PROJECT_ROOT

python main.py &

sleep 5

echo "Try to get OpenAPI schema..."
while true; do
    wget http://127.0.0.1:8888/openapi.json
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 5  # Wait for 5 seconds before retrying
done
echo "OpenAPI schema generated at openapi.json"

# On exit, kill the whole process group.
# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
