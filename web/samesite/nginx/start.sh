#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo "start frontend & backend on localhost:3001"

docker run -it --rm -p 3001:3001 -v $(pwd)/default.conf:/etc/nginx/conf.d/default.conf nginx
