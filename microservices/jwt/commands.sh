#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python server.py
curl -u test:test http://localhost:5000/login
# {
#   "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJleHAiOjE2OTE5ODAzNzd9.lK6oXEHXs5G4s8l6uhLyP_WZd63BfxhXy1PmaBanp_E"
# }

TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJleHAiOjE2OTE5ODAzNzd9.lK6oXEHXs5G4s8l6uhLyP_WZd63BfxhXy1PmaBanp_E
curl -H "x-access-tokens: $TOKEN" http://localhost:5000/protected
# {
#   "message": "Hello pbkdf2:sha256:600000$71KlgbkaeyPE7LLk$9bc8bfa910c52b6be848124e1d8f43af74043cde5dc5f620a83d24c622dcca79, you are viewing a protected endpoint!"
# }

./build.sh
#  => => naming to docker.io/library/test-pyjwt:latest

docker run -it --rm test-pyjwt:latest
#  * Serving Flask app 'server'
#  * Debug mode: on
# WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
#  * Running on http://127.0.0.1:5000
# Press CTRL+C to quit
#  * Restarting with stat
#  * Debugger is active!
#  * Debugger PIN: 799-450-048
