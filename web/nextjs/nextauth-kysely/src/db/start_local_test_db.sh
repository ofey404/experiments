#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo "Starting postgres..."
docker run -itd --rm \
           --name test-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -e POSTGRES_DB=test \
           -p 5432:5432 \
           postgres:16

echo "Waiting for postgres to start..."
until PGPASSWORD=mysecretpassword psql -h localhost -U postgres -d test -c '\q'; do
  >&2 echo "Waiting for postgres to start..."
  sleep 1
done
>&2 echo "Postgres is up!"

echo "Creating schema..."
docker run --rm -v $(pwd)/migration:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/test \
     -user=postgres \
     -password=mysecretpassword \
     migrate

echo "Connect to the database:"
echo "PGPASSWORD=mysecretpassword psql -h localhost -U postgres -d test"
echo "postgres://postgres:mysecretpassword@localhost:5432/test"
echo ""
echo "Stop and remove the container with:"
echo "docker stop test-postgres"