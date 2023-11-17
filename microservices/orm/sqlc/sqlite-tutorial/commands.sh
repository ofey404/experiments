#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest

sqlc generate

go run .
# 2023/11/17 13:54:03 authors = []
# 2023/11/17 13:54:03 insertedAuthor = {ID:1 Name:Brian Kernighan Bio:{String:Co-author of The C Programming Language and The Go Programming Language Valid:true}}
# 2023/11/17 13:54:03 reflect.DeepEqual(insertedAuthor, fetchedAuthor) = %!b(bool=true)

