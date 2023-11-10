#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kubectl apply -f all.yaml
#service/volume-claim-retain-test created
#statefulset.apps/volume-claim-retain-test created

kubectl delete -f all.yaml
#service "volume-claim-retain-test" deleted
#statefulset.apps "volume-claim-retain-test" deleted

# This provisioned PVC still exists
kubectl get pvc
#NAME                                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
#www-volume-claim-retain-test-0                   Bound    pvc-a04f6565-c945-4338-b8aa-89780746abc1   20Gi       RWO            ebs-ssd        77s
