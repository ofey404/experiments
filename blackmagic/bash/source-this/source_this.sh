#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# [bash - How to define a shell script to be sourced not run - Unix & Linux Stack Exchange](https://unix.stackexchange.com/questions/424492/how-to-define-a-shell-script-to-be-sourced-not-run)
if [ "${BASH_SOURCE[0]}" -ef "$0" ]
then
    echo "Hey, you should source this script, not execute it!"
    exit 1
fi

echo "Sourcing $SCRIPT_DIR/source_this.sh"