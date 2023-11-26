#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# filter {serial number}-{solution name}.go by unique serial number

echo "Problems finished in 1 week:"
find . -name '*.go' -mtime -7 | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l

echo "Problems finished in 1 month:"
find . -name '*.go' -mtime -30 | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l

echo "All problems solved:"
find . -name '*.go' | sed -E 's/.*\/([0-9]+)-.*\.go/\1/' | sort -u | wc -l
