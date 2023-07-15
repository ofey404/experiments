#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# local test #################################
backend/launch.sh
frontend/launch.sh

# docker test ################################
# auth0-go-zero-backend:latest
backend/build.sh
# auth0-go-zero-frontend:latest
frontend/build.sh

backend/docker-launch.sh
frontend/docker-launch.sh
