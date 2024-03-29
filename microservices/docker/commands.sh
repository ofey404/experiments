#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# always pull latest image
docker run --pull always nginx:1.19.6-alpine

# find out entrypoint
docker inspect --format='{{json .Config.Entrypoint}}' nginx:1.19.6-alpine
# ["/docker-entrypoint.sh"]
docker run --rm -it --entrypoint cat nginx:1.19.6-alpine /docker-entrypoint.sh
