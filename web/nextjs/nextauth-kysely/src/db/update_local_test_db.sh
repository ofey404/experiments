#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo "Migrating schema..."
docker run --rm -v $(pwd)/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/test \
     -user=postgres \
     -password=mysecretpassword \
     migrate
