#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# spin up a postgres
docker run -it --rm \
           --name some-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -p 5432:5432 \
           postgres:16

# init schema
docker cp ./schema/schema-postgresql.sql some-postgres:/schema-postgresql.sql
docker exec -it some-postgres psql -U postgres -d postgres -f /schema-postgresql.sql

go run . --driver "postgres" --conn "postgres://postgres:mysecretpassword@localhost:5432/postgres?sslmode=disable"
# The author of the hobbit is: jrr tolkien
# Authors born in 19th century:
# jrr tolkien

# spin up a mysql
docker run -it --rm \
           --name some-mysql \
           -e MYSQL_ROOT_PASSWORD=mysecretpassword \
           -p 3306:3306 \
           mysql:8

# init schema
docker cp ./schema/schema-mysql.sql some-mysql:/schema-mysql.sql
docker exec -it some-mysql mysql -u root -pmysecretpassword -e "source /schema-mysql.sql"

go run . --driver "mysql" --conn "root:mysecretpassword@tcp(localhost:3306)/mysql"
# 2023/11/20 16:59:12 Error 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'RETURNING id, name, birth_date' at line 4
# {"@timestamp":"2023-11-20T16:59:12.188+08:00","content":"Error 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'RETURNING id, name, birth_date' at line 4","level":"fatal"}
# exit status 1
