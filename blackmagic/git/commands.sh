#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#####################################################################
# Worktree
#####################################################################

# checkout a branch called experiments-worktree-branch-1
# in a separate directory
git worktree add ../experiments-worktree-branch-1


#####################################################################
# Git contribution stats
#####################################################################

# list all authors (Take this repo as example)
git log --format='%aN' | sort -u
# Ofey Chan
# Weiwen Chen

# print stats for a specific author
git log --author="Ofey Chan" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "Added lines: %s, Removed lines: %s, Total lines: %s\n", add, subs, loc }'
# Added lines: 329553, Removed lines: 22675, Total lines: 306878

# print for all
git log --all --numstat --pretty=format:%n%ae --no-merges | awk '
    NF==1 {user=$1}
    NF==3 {added[user]+=$1; removed[user]+=$2}
    END {
        for (user in added) {
            printf "Author: %-30s | Added lines: %8d | Removed lines: %8d | Total lines: %8d\n", user, added[user], removed[user], added[user]-removed[user]
        }
    }' | sort
# Author: ofey206@gmail.com              | Added lines:   469244 | Removed lines:    23294 | Total lines:   445950
