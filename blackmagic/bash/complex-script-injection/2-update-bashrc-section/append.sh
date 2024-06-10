#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

ANCHOR_START="# == MY_ANCHOR_2_START =="
ANCHOR_END="# == MY_ANCHOR_2_END =="
BASHRC_PATH="$SCRIPT_DIR/bashrc"

if ! grep -q "$ANCHOR_START" "$BASHRC_PATH" || ! grep -q "$ANCHOR_END" "$BASHRC_PATH"; then
    # A new line is required in case bashrc file is empty
    cat << EOF >> "$BASHRC_PATH"

$ANCHOR_START
# The following is the section that will be updated automatically,
# 
# If this section not exist in bashrc, append.sh script would add it.
$ANCHOR_END
EOF
fi
