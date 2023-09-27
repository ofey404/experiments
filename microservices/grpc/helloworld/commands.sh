#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# to use python protobuf
python -m pip install grpcio grpcio-tools google


# pick commands from them
python python/greeter_server.py
python python/greeter_client.py
go run greeter_server/main.go
go run greeter_client/main.go
