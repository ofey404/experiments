#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://superset.apache.org/docs/quickstart/
#
# docker-compose-image-tag.yml and docker/
# are from: https://github.com/apache/superset/blob/master/

docker compose up
# http://localhost:8088
# username: admin
# password: admin

# Visit host.docker.internal to access local/port-forward databases