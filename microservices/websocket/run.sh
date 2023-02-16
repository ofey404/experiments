#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

go run . 127.0.0.1:5000 &

echo "## wait for server to start"
sleep 1

echo "## authenticated with a hardcoded token in header"
echo "## now you can type like echo command"
wscat -c ws://127.0.0.1:5000?hello=1 -s echo --header "token:hardcoded token"

# On exit, kill the whole process group.
# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

# Or you do cleanup with:
# sudo lsof -nP -iTCP:5000 -sTCP:LISTEN
