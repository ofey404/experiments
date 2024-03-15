#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

run_all_sh() {
    for f in $1/*.sh; do
        bash $f
    done
}

run_all_sh $SCRIPT_DIR/scripts

# check if the variable is set
if [[ -n "${OPTIONAL_SCRIPT_DIR+x}" ]]; then
    echo "\$OPTIONAL_SCRIPT_DIR is set as $OPTIONAL_SCRIPT_DIR"

    # check if the directory exists
    if [[ ! -d "$OPTIONAL_SCRIPT_DIR" ]]; then
        echo "Directory $OPTIONAL_SCRIPT_DIR does not exist, exiting..."
        exit 1
    fi

    run_all_sh $OPTIONAL_SCRIPT_DIR
else
    echo "\$OPTIONAL_SCRIPT_DIR is not set"
fi
