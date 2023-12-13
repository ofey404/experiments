#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://www.sqlalchemy.org/
# Tutorial: https://docs.sqlalchemy.org/en/20/tutorial/index.html

pip install -r requirements.txt
python -c "import sqlalchemy; print(sqlalchemy.__version__)"
# 2.0.19
