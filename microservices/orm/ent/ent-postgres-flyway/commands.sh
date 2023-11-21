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
