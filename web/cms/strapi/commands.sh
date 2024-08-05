#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://strapi.io/

# some posts says strapi is a mess, and writing a CMS is not so hard.
# https://www.reddit.com/r/Frontend/comments/1183gl1/whats_the_pros_and_cons_of_strapi/
# https://www.reddit.com/r/javascript/comments/febof5/askjs_what_do_you_think_of_strapi/
#
# As soon as you want a little complexity, those pre-built solutions are bad.

