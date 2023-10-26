#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

PROJECT_ROOT="$SCRIPT_DIR"/../..
cd $PROJECT_ROOT

# 1. init project as a standalone go module
mkdir -p ~/projects/guestbook
cd ~/projects/guestbook
kubebuilder init --domain my.domain --repo my.domain/guestbook

# Alternative 1. init project as a subpackage of an existing module
mkdir -p projects/guestbook
cd projects/guestbook
kubebuilder init --domain my.domain --repo github.com/ofey404/experiments/cloud/kubebuilder/projects/guestbook
rm go.mod go.sum
# Then modify the Dockerfile, point the root path to the existing go.mod

# 2. create API
kubebuilder create api --group webapp --version v1 --kind Guestbook

make install
make run

