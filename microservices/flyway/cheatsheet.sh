#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# This is a cheatsheet of commands,
# to spin up a test environment.
##############################################

# create disposable postgres on localhost:5432
docker run -it --rm \
           --name test-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -p 5432:5432 \
           -v /tmp/postgres-flyway:/var/lib/postgresql/data \
           postgres:16
docker exec -it test-postgres psql -U postgres -c "CREATE DATABASE testdb"

# connect
PGPASSWORD=mysecretpassword psql -h localhost -U postgres -d testdb

# create schema from `db/migrations/postgres`
docker run --rm -v $(pwd)/db/migrations/postgres:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/testdb \
     -user=postgres \
     -password=mysecretpassword \
     migrate
