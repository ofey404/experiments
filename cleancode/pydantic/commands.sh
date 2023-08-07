#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python parse_obj.py
## Existing instance
#{
#  "field1": "default",
#  "field2": 0,
#  "field3": "This should not change"
#}
## Update with new data
#{'field1': 'new value', 'field2': 1}
## Update the existing instance
#{
#  "field1": "new value",
#  "field2": 1,
#  "field3": "This should not change"
#}
