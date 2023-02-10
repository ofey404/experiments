#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

docker-compose up -d

# Create a topic
docker exec broker \
kafka-topics --bootstrap-server broker:9092 \
--create \
--if-not-exists \
--topic test

go test -bench . -cpu=2,4 | tee bench.log
