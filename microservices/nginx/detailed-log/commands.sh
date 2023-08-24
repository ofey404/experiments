#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

docker run -it --rm \
-v $(pwd)/nginx.conf:/etc/nginx/nginx.conf:ro \
-p 8080:80 \
nginx

# the outcome is not so good.
