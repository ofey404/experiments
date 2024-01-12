#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# kaniko executor image doesn't contain a shell
#
# https://stackoverflow.com/questions/56747223/kaniko-sh-sleep-not-found
docker run -it --entrypoint=/busybox/sh gcr.io/kaniko-project/executor:debug

#####################################################################
# in k8s
#####################################################################

kubectl apply -f debug-builder.yaml

# ssh in pod, then
cd /workspace

cat <<EOF > Dockerfile
FROM alpine
ENTRYPOINT echo "created from kaniko, in k8s"
EOF

cat <<EOF > /kaniko/.docker/config.json
{
  "auths": {
    "https://index.docker.io/v1/": {
      "auth": "xxx"
    }
  }
}
EOF

/kaniko/executor --dockerfile=Dockerfile --destination=xxx
