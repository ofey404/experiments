#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

./generate.sh

#####################################################################
# run the service
#####################################################################

go run . -f etc/hellokv-api.yaml

#####################################################################
# test commands
#####################################################################
curl -v localhost:8888/getkey -H "Content-Type: application/json" \
-d '{ "key": "myKey" }'

curl -v localhost:8888/setkey -H "Content-Type: application/json" \
-d '{ "key": "myKey", "value": "myValue" }'
