#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go install github.com/spf13/cobra-cli@latest

# cd <project-root>
cobra-cli init

cobra-cli add serve
cobra-cli add config
cobra-cli add create -p 'configCmd'

# This cli-generator doesn't add too much value.
#
# The recommended project structure is enough:
# https://github.com/spf13/cobra/blob/main/site/content/user_guide.md
