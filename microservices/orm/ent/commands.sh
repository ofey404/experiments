#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://entgo.io/docs/getting-started/
go run -mod=mod entgo.io/ent/cmd/ent new User

# edit schema, add field, then generate
go generate ./ent

# manage the first entity
go run .
# 2023/11/21 10:26:33 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:26:33 user returned:  User(id=1, age=30, name=a8m)
