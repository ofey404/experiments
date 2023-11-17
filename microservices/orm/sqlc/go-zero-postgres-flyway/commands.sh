#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# We reuse postgres created from microservices/flyway/commands.sh
# create database
docker exec -it some-postgres psql -U postgres -c "CREATE DATABASE hellokv"
# create database schema
docker run --rm -v $(pwd)/model/db/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/hellokv \
     -user=postgres \
     -password=mysecretpassword \
     migrate

# dump schema
docker run --rm -it -e PGPASSWORD=mysecretpassword \
       postgres:16 \
       bash -c "pg_dump -h host.docker.internal -U postgres -s -d hellokv" > model/db/schema/V1.sql

./generate.sh

#####################################################################
# run the service
#####################################################################

go run . -f etc/hellokv-api.yaml

#####################################################################
# test commands
#####################################################################
curl -v localhost:8888/getkey -H "Content-Type: application/json" \
-d '{ "key": "myKey" }'

curl -v localhost:8888/setkey -H "Content-Type: application/json" \
-d '{ "key": "myKey", "value": "myValue" }'
