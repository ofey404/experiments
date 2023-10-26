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

# Oh shit, the whole lotta tutorial is not in a good code style.
# The controller.go is a top-down spaghetti script. Very hard to read.
#
# So never follow the tutorial, just copy the source code from here:p
# https://github.com/kubernetes-sigs/kubebuilder/blob/master/docs/book/src/cronjob-tutorial/testdata/project/internal/controller/cronjob_controller.go

# Here is another kubebuilder bug, we should add crd:maxDescLen=0 in Makefile:
#
# metadata.annotations: Too long: must have at most 262144 bytes #2556
# https://github.com/kubernetes-sigs/kubebuilder/issues/2556

# finally... Apply our test cronjob.
kubectl apply -f examples/cronjob.yaml

kubebuilder create webhook --group batch --version v1 --kind CronJob --defaulting --programmatic-validation
