#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

while true; do
    wget http://127.0.0.1:8888/openapi.json
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 5  # Wait for 5 seconds before retrying
done
