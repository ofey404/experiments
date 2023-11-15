#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# start at localhost:8888
jupyter lab \
  --notebook-dir="${HOME}" \
  --ip=0.0.0.0 \
  --no-browser \
  --allow-root \
  --port=8888 \
  --ServerApp.token="" \
  --ServerApp.password="" \
  --ServerApp.allow_origin="*" \
  --ServerApp.authenticate_prometheus=False
#   --ServerApp.base_url="${NB_PREFIX}"

curl --silent localhost:8888/api/kernels | jq
# [
#   {
#     "id": "4ef85989-3597-4711-a8da-fe7dd0615db0",
#     "name": "python3",
#     "last_activity": "2023-11-15T06:25:17.718915Z",
#     "execution_state": "idle",
#     "connections": 1
#   }
# ]
#
# Run some workload...
# 
# [
#   {
#     "id": "4ef85989-3597-4711-a8da-fe7dd0615db0",
#     "name": "python3",
#     "last_activity": "2023-11-15T06:35:18.448409Z",
#     "execution_state": "busy",
#     "connections": 1
#   }
# ]

go run .
# resp.StatusCode: 200
# kernels: [
#   {
#     "id": "4ef85989-3597-4711-a8da-fe7dd0615db0",
#     "name": "python3",
#     "last_activity": "2023-11-15T06:35:18.448409Z",
#     "execution_state": "idle",
#     "connections": 1
#   }
# ]
# k.MustParseLastActivity() = 2023-11-15T06:35:18Z
