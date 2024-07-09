#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://stackoverflow.com/a/30737248/11978156

#####################################################################
# Github documentation contains a script that replaces the committer info for
# all commits in a branch (now irretrievable, this is the last snapshot). Run
# the following script from terminal after changing the variable values
#####################################################################

#!/bin/sh
 
git filter-branch --env-filter '
 
OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

#####################################################################
# Push the corrected history to GitHub:
#####################################################################

git push --force --tags origin 'refs/heads/*'

#####################################################################
# OR if you like to push selected references of the branches then use
#####################################################################

git push --force --tags origin 'refs/heads/develop'