#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

BASHRC_PATH="$SCRIPT_DIR/bashrc"
ANCHOR_START="# == MY_ANCHOR_START =="
ANCHOR_END="# == MY_ANCHOR_END =="

# Create a temporary file for the new bashrc content
TEMP_BASHRC=$(mktemp)

# Ensure the temporary file is removed on script exit
trap "rm -f $TEMP_BASHRC" EXIT

# Read .bashrc up to the start anchor and write to the temp file
sed "/$ANCHOR_START/,\$d" $BASHRC_PATH > $TEMP_BASHRC

# Append the new content within the anchors using cat for multiple line strings
cat << EOF >> $TEMP_BASHRC
$ANCHOR_START
# The following is the section that will be updated automatically,
# DON'T EDIT IT
echo 'This is a dummy line 1'
echo 'This is a dummy line 2'
echo 'Update date is: $(date)'
$ANCHOR_END
EOF

# Append the rest of the original .bashrc file after the end anchor
# Using 'tail' to skip the first line of the matched pattern to avoid duplicating the end anchor
tail -n +2 <(sed -n "/$ANCHOR_END/,\$p" $BASHRC_PATH) >> $TEMP_BASHRC

# Replace the original .bashrc with the updated version
mv $TEMP_BASHRC $BASHRC_PATH
