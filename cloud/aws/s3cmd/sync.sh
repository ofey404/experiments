#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# This command shows how to use a bucket as cloud file storage.

find . -type f -name '*:Zone.Identifier' -exec rm -f {} \;
s3cmd sync . s3://my-archive --delete-removed
