#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# spin up a postgres container
docker run -it --rm \
           --name some-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -p 5432:5432 \
           postgres:16
# to persist the data:
#    -v /tmp/postgres-example:/var/lib/postgresql/data

# connect to it
PGPASSWORD=mysecretpassword psql -h localhost -U postgres
