#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo "Starting Vault dev server.."
docker-compose up --build -d

echo "sleep 10 seconds, to wait for vault server to come online"
sleep 10

echo "Running quickstart example."
go run main.go

echo "Stopping Vault dev server.."
docker-compose rm -fsv

echo "Vault server has stopped."
