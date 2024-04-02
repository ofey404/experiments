#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo_loop() {
    while :
    do
        echo "$@"
        sleep 1
    done
}

echo_loop "Process 1" &
echo_loop "Process 2" &
echo_loop "Process 3"

# On exit, kill the whole process group.
# https://stackoverflow.com/questions/360201/how-do-i-kill-background-processes-jobs-when-my-shell-script-exits
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
