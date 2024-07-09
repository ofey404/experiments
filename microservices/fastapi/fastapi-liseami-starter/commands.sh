#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python -m venv venv
source venv/bin/activate
pip install poetry
sudo apt install postgresql-common libpq-dev
poetry install

# run more when I need it. Now I trust liseami.
