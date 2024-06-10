#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

SSH_DIR=$SCRIPT_DIR

mkdir -p $SSH_DIR
if [ ! -f $SSH_DIR/authorized_keys ]; then
	echo "$SSH_DIR/authorized_keys does not exist"
	mv authorized_keys_2 $SSH_DIR/authorized_keys
else
	echo "$SSH_DIR/authorized_keys exists, merge them"
	cat authorized_keys_2 <(echo) $SSH_DIR/authorized_keys | sort -u > $SSH_DIR/authorized_keys_merged
fi
chmod 644 $SSH_DIR/authorized_keys
