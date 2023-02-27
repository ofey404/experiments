#!/usr/bin/env bash
# set -x             # for debug
set -o errexit
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

go run -race race.go > safe.log 2>&1
go run -race race.go -unsafe > unsafe.log 2>&1
