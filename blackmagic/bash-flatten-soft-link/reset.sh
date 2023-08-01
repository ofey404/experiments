#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

rm -rf playground/
mkdir -p playground/
cd playground/

echo "file 1" > source.txt
ln -s source.txt link.txt

mkdir -p nested/
cd nested/

ln -s ../source.txt nested-link.txt
