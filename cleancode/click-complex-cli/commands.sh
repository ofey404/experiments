#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

pip install click

python 1-pass-obj.py 
# Usage: 1-pass-obj.py [OPTIONS] COMMAND [ARGS]...
# 
# Options:
#   --repo-home TEXT
#   --debug / --no-debug
#   --help                Show this message and exit.
# 
# Commands:
#   clone

python 1-pass-obj.py clone src
# Cloning src into None
# Repo JSON = {"home":"/home/ofey","version":0}

python 2-complex-pass-ctx.py stash pop
# cli() called
# repo_home = .repo
# debug = False
# stash() called
# Repo JSON = {"home":"/home/ofey","comment":"created in cli()"}
# pop() called
# Stash JSON = {"file_list":["file1","file2"]}
# Repo JSON = {"home":"/home/ofey","comment":"created in cli()"}
