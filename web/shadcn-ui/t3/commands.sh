#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://ui.shadcn.com/examples/dashboard
# https://ui.shadcn.com/docs/installation/next

npx shadcn-ui@latest init

# We have default font so we don't change it.

# add component:
npx shadcn-ui@latest add button
