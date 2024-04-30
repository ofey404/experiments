#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://medium.com/@debpanda17/5-best-tables-in-react-pros-and-cons-5c5d08cfe69a
# 
# 2 candidates:
# https://github.com/TanStack/table
# https://github.com/GriddleGriddle/Griddle

# init project
npx create-react-app react-table --template typescript
cd react-table

npm install @tanstack/react-table

# Columns with Drag and Drop - How would you implement? #3953
# https://github.com/TanStack/table/discussions/3953

npm install @dnd-kit/core @dnd-kit/modifiers @dnd-kit/sortable @dnd-kit/utilities @faker-js/faker