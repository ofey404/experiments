#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# CHANGE THIS: If we move the script.
SERVICE_ROOT=$SCRIPT_DIR

cd "$SERVICE_ROOT"

echo "## Please run it against a fresh backend service"

curl -X POST localhost:8888/api/get -H "Content-Type: application/json" -d '{
  "key": "key"
}'

echo ""

curl -X POST localhost:8888/api/set -H "Content-Type: application/json" -d '{
  "key": "key",
  "value": "value"
}'

echo ""

curl -X POST localhost:8888/api/get -H "Content-Type: application/json" -d '{
  "key": "key"
}'

echo ""
