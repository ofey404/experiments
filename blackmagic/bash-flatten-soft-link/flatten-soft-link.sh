#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# find all link with
#
# find . -type l -ls

cd "$SCRIPT_DIR"

dir="playground/"

find "$dir" -type l -print0 | while IFS= read -r -d '' file; do
    dest=$(readlink -f "$file")
    if [ -e "$file" ]; then
        rm "$file"
        cp -r "$dest" "$file"
    fi
done
