#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# GitHub: https://github.com/marmelab/react-admin
#
# a informative post:
# https://www.reddit.com/r/reactjs/comments/11vj5rz/anyone_using_reactadmin/
#
# Pros: They acclerate CRUD app, have complete headless counterpart, and great documentation.
# Cons: Potential risk to be too rigid.

# Alternative: 
# https://mui.com/toolpad/
# https://refine.dev/

# https://marmelab.com/react-admin/Tutorial.html
npm init react-admin 1-tutorial
# JSON server, `None` auth provider

cd 1-tutorial
npm run dev

# Use JSON placeholder, See web/placeholders/commands.sh
