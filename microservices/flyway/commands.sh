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

# create database
# flyway doesn't provide a flag like `--create-database`
docker exec -it some-postgres psql -U postgres -c "CREATE DATABASE mydatabase"

# https://hub.docker.com/r/flyway/flyway
docker run --rm -v $(pwd)/db/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/mydatabase \
     -user=postgres \
     -password=mysecretpassword \
     migrate

# SQL are from https://github.com/timander/flyway-example

#####################################################################
# Advanced options
#####################################################################

# remove postgres data, and start over, migrate to v3
sudo rm -rf /tmp/postgres-flyway

docker run --rm -v $(pwd)/db/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/mydatabase \
     -user=postgres \
     -password=mysecretpassword \
     migrate -target=3
