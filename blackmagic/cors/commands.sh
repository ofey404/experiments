#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://stackoverflow.com/questions/12173990/how-can-you-debug-a-cors-request-with-curl

# Sending a regular CORS request using cUrl:
curl -H "Origin: http://example.com" --verbose \
  https://www.googleapis.com/discovery/v1/apis?fields=

# Sending a preflight request using cUrl:
curl -H "Origin: http://example.com" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: X-Requested-With" \
  -X OPTIONS --verbose \
  https://www.googleapis.com/discovery/v1/apis?fields
