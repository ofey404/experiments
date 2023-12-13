#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

docker run -it --rm -p 80:80 -v $(pwd):/etc/nginx/conf.d --name nginx-backend-proxy nginx /bin/bash
docker run -it --rm -p 80:80 -v $(pwd):/etc/nginx/conf.d --name nginx-backend-proxy nginx
