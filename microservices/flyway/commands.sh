#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# postgres data
mkdir /tmp/postgres-flyway

# spin up a postgres container
docker run -it --rm \
           --name some-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -p 5432:5432 \
           -v /tmp/postgres-flyway:/var/lib/postgresql/data \
           postgres:16

# https://github.com/flyway/flyway
# https://hub.docker.com/r/flyway/flyway
docker run --rm -v /path/to/sql/migrations:/flyway/sql flyway/flyway \
    -url=jdbc:postgresql://host.docker.internal:5432/mydatabase -user=postgres -password=mysecretpassword migrate
