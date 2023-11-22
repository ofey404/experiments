#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run -mod=mod entgo.io/ent/cmd/ent new User --target internal/ent/schema

# edit schema, add field, then generate
go generate ./internal/ent

#####################################################################
# Option 1: Use the atlas migrate diff command
# The output is consumed by the atlas migrate apply command.
#####################################################################
atlas migrate diff create_user \
  --dir "file://internal/ent/migrate/migrations" \
  --to "ent://internal/ent/schema" \
  --dev-url "docker://postgres/15/test?search_path=public"

cat ent/migrate/migrations/20231121033810_create_user.sql
# -- Create "users" table
# CREATE TABLE "users" ("id" bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY, PRIMARY KEY ("id"));

# inspect the schema
atlas migrate lint \
  --dev-url="docker://postgres/15/test?search_path=public" \
  --dir="file://ent/migrate/migrations" \
  --latest=1

#####################################################################
# Option 2: Create a migration generation script
# This output could be used by flyway.
#####################################################################

# remove outputs
rm ent/migrate/migrations/*

touch ent/migrate/main.go

# regenrate schema
# //go:generate go run -mod=mod entgo.io/ent/cmd/ent generate --feature sql/versioned-migration ./schema
go generate ./ent

# spin up a empty postgres
docker run --name migration -it --rm -p 5432:5432 -e POSTGRES_PASSWORD=pass -e POSTGRES_DB=migration postgres

# generate flyway migration script
go run -mod=mod ent/migrate/main.go create_users

# add fields to schema
go generate ./ent
go run -mod=mod ent/migrate/main.go user_add_name_age

ls ent/migrate/migrations/
# U20231121055737__create_users.sql  U20231121060516__user_add_name_age.sql  V20231121055737__create_users.sql  V20231121060516__user_add_name_age.sql  atlas.sum

#####################################################################
# Apply to postgresql
#####################################################################

# create database and schema
docker run -it --rm \
           --name some-postgres \
           -e POSTGRES_PASSWORD=mysecretpassword \
           -e POSTGRES_DB=test \
           -p 5432:5432 \
           postgres:16
docker run --rm -v $(pwd)/ent/migrate/migrations:/flyway/sql flyway/flyway:10.0 \
     -url=jdbc:postgresql://host.docker.internal:5432/test \
     -user=postgres \
     -password=mysecretpassword \
     migrate

# datasource:
# postgres://postgres:mysecretpassword@localhost:5432/test?sslmode=disable

go run .
# Latest schema version: 20231121060516
# 2023/11/21 14:18:55 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 14:18:55 user returned:  User(id=1, age=30, name=a8m)
