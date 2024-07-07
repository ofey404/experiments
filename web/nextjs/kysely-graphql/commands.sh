#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

npm install kysely pg axios next-auth@beta @auth/pg-adapter
npm install --save-dev @types/pg daisyui@latest kysely-codegen

# postgres -> graphql
# https://dev.to/franciscomendes10866/how-to-build-a-type-safe-graphql-api-using-pothos-and-kysely-4ja3
#
# pothos has support of nextjs api route
npm install @pothos/core graphql-yoga @pothos/plugin-simple-objects

npm i graphql @apollo/client @apollo/server
