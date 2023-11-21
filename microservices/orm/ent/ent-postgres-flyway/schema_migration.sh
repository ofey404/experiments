#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# CHANGE THIS: If we move the script.
SERVICE_ROOT=$SCRIPT_DIR

cd "$SERVICE_ROOT"

# Check if the migration name argument is provided
if [ -z "${1:-}" ]; then
  echo "Usage: $0 <migration_name>"
  echo "Please provide the name of the migration as the first argument."
  exit 1
fi

cd "$SERVICE_ROOT"

echo "Generating schema in $(pwd)/ent"
go generate ./ent

echo "Generating schema migration in $(pwd)/ent/migrate"
go run -mod=mod ent/migrate/main.go "$1"
