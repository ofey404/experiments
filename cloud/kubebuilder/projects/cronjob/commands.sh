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

#####################################################################
# Develop a Webhook
#####################################################################

kubebuilder create webhook --group batch --version v1 --kind CronJob --defaulting --programmatic-validation
# also, just copy cronjob_webhook.go from
# https://github.com/kubernetes-sigs/kubebuilder/blob/master/docs/book/src/cronjob-tutorial/testdata/project/api/v1/cronjob_webhook.go

# Install cert-manager
# https://book.kubebuilder.io/cronjob-tutorial/cert-manager
# https://cert-manager.io/docs/installation/
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.1/cert-manager.yaml

make docker-build IMG=kubebuilder-cronjob:v0.0.1
kind load docker-image kubebuilder-cronjob:v0.0.1 --name jupyterhub

# Then, uncomment the webhook manifest in config/crd/ and config/default

make deploy IMG=kubebuilder-cronjob:v0.0.1

# check the validation webhook is working correctly
kubectl apply -f examples/cronjob-wrong-format.yaml
# The CronJob "cronjob-example" is invalid: spec.schedule: Invalid value: "A cron expression with wrong format": Expected exactly 5 fields, found 6: A cron expression with wrong format

make undeploy
