#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# CHANGE THIS: If we move the script.
SERVICE_ROOT=$SCRIPT_DIR

cd "$SERVICE_ROOT"

go build -o bin/backend .

docker build -t auth0-go-zero-backend:latest .
