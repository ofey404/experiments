#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

npm install kysely
npm install pg   # driver dependency
npm i --save-dev @types/pg
npm install axios
npm i -D daisyui@latest
npm install --save-dev kysely-codegen  # generated types

# generate postgres types
./src/db/start_local_test_db.sh
kysely-codegen

#####################################################################
# Auth.js (NextAuthV5)
# https://authjs.dev
#####################################################################

npm install next-auth@beta
npm install @auth/pg-adapter pg
npx auth secret