#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/minio/minio

docker run -p 9000:9000 -p 9001:9001 \
  quay.io/minio/minio server /data --console-address ":9001"

# http://localhost:9001/login
#
# Username, password:
# minioadmin:minioadmin
