#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# same configuration as microservices/flyway/commands.sh
# except the persistence volume
docker run -it --rm \
           --name some-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -p 5432:5432 \
           postgres:16
# create database
docker exec -it some-postgres psql -U postgres -c "CREATE DATABASE hellokv"
# create database schema
docker run --rm -v $(pwd)/model/db/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/hellokv \
     -user=postgres \
     -password=mysecretpassword \
     migrate \
     -target=1

#####################################################################
# V1
#####################################################################

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

#####################################################################
# V2
#####################################################################

# upgrade to V2
docker run --rm -v $(pwd)/model/db/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/hellokv \
     -user=postgres \
     -password=mysecretpassword \
     migrate \
     -target=2
# dump schema
docker run --rm -it -e PGPASSWORD=mysecretpassword \
       postgres:16 \
       bash -c "pg_dump -h host.docker.internal -U postgres -s -d hellokv" > model/db/schema/V2.sql

# Exit when connecting to the database with new schema
go run . -f etc/hellokv-api.yaml
# Successfully connected!
# {"@timestamp":"2023-11-20T10:12:53.693+08:00","caller":"svc/servicecontext.go:68","content":"schema version is too new, service version 1, db version 2","level":"error"}
# exit status 1

mkdir -p model/modelv2
touch model/modelv2/{sqlc.yaml,V2__query.sql}

./generate.sh

# Then we edit the service code
