#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# build a custom data provider (TRPC as example)
# https://marmelab.com/react-admin/Tutorial.html#connecting-to-a-real-api
# https://github.com/marmelab/react-admin/blob/master/packages/ra-data-json-server/src/index.ts
# https://marmelab.com/react-admin/NextJs.html

# My Data Provider doesn't work.
# A correct implementation see: https://github.com/mwarger/ra-trpc/blob/main/packages/ra-trpc/src/client.ts
