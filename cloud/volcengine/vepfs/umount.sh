#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

ARG_COUNT=$#
if [[ ARG_COUNT -ne 2 ]]; then
    echo "## Wront input: $@"
    echo ""
    echo "## Usage: $0 <ip_list_file> <machine_id>"
    cat <<EOF

ip_list_file format:

<machine_id> <internal_ip>
<machine_id> <internal_ip>
...

example:

0 192.168.0.32
1 192.168.0.35
2 192.168.0.36
3 192.168.0.37
...
EOF
    exit 1
fi

IP_LIST_FILE=$1
MACHINE_ID=$2

echo "## Finding Internal IP for machine ID $MACHINE_ID"

# This line would fail silently if the machine id is not found.
# I don't have time to fix it now.
INTERNAL_IP=$(grep "^${MACHINE_ID} " "$IP_LIST_FILE" | awk '{print $2}')

echo "## Internal IP for machine ID $MACHINE_ID: $INTERNAL_IP"

vepfs del $INTERNAL_IP
