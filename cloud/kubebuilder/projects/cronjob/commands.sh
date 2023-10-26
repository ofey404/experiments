#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Tutorial: Building CronJob
# https://book.kubebuilder.io/cronjob-tutorial/cronjob-tutorial

kubebuilder init --domain tutorial.kubebuilder.io --repo github.com/ofey404/experiments/cloud/kubebuilder/projects/cronjob
rm go.mod go.sum
# Then modify the Dockerfile, point the root path to the existing go.mod

kubebuilder create api --group batch --version v1 --kind CronJob
make manifests
