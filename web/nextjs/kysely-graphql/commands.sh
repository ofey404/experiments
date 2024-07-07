#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/kysely-org/kysely
# https://dev.to/franciscomendes10866/how-to-build-a-type-safe-graphql-api-using-pothos-and-kysely-4ja3

npm install kysely pg axios next-auth@beta @auth/pg-adapter
npm install --save-dev @types/pg daisyui@latest kysely-codegen

# https://authjs.dev/guides/configuring-github
# register an app in https://github.com/settings/developers
