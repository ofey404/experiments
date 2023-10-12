#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# UUID: f298b16f-5ec1-41e0-a614-33a6dd76f4d7

kubectl apply -f k8s-name-max-length.yaml
# After we applied uuid, the remaining space is like:
#
# k8s-support-63-character---f298b16f-5ec1-41e0-a614-33a6dd76f4d7
#                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#                                         UUID characters
