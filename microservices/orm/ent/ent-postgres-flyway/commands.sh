#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run -mod=mod entgo.io/ent/cmd/ent new User

# generate service code
./generate.sh

# edit schema, add field, then generate code
./schema_migration.sh create_schema
# Generating schema in /home/ofey/cloud-workspace/experiments/microservices/orm/ent/ent-postgres-flyway/ent
#
# Generating schema migration in /home/ofey/cloud-workspace/experiments/microservices/orm/ent/ent-postgres-flyway/ent/migrate/migrations
# Migration name create_schema
# Migration file:
# U20231121070457__create_schema.sql
# V20231121070457__create_schema.sql

#####################################################################
# Start service with postgres backend
#####################################################################

# create database and schema
docker run -it --rm \
           --name some-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -e POSTGRES_DB=hellokv \
           -p 5432:5432 \
           postgres:16
docker run --rm -v $(pwd)/ent/migrate/migrations:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/hellokv \
     -user=postgres \
     -password=mysecretpassword \
     migrate

go run . -f etc/hellokv-api.yaml
# Using database driver postgres, source postgres://postgres:mysecretpassword@localhost:5432/hellokv?sslmode=disable...
# Starting server at 0.0.0.0:8888...

#####################################################################
# test commands
#####################################################################
curl -v localhost:8888/getkey -H "Content-Type: application/json" \
-d '{ "key": "myKey" }'

curl -v localhost:8888/setkey -H "Content-Type: application/json" \
-d '{ "key": "myKey", "value": "myValue" }'
