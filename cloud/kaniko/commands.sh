#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/GoogleContainerTools/kaniko

kind create cluster -n kaniko
docker update --restart=no kaniko-control-plane

source env.sh  # see env-example.sh
# check the credentials are valid
docker login -u $DOCKER_USERNAME \
             -p $DOCKER_PASSWORD \
             $DOCKER_REGISTRY_URL
# Login Succeeded

#####################################################################
# build from stdin, given a tarball context
# then push to an unencrypted registry
#####################################################################

# https://github.com/GoogleContainerTools/kaniko?tab=readme-ov-file#using-standard-input
tar -cf - Dockerfile | gzip -9 | docker run \
  --interactive --rm -v $(pwd):/workspace gcr.io/kaniko-project/executor:v1.19.1 \
  --context tar://stdin \
  --destination=$DESTINATION_NOLOGIN
# INFO[0003] Pushing image to ...

docker run --pull always $DESTINATION_NOLOGIN
# created from kaniko

#####################################################################
# push to a registry that requires login
#####################################################################
cat <<EOF > config.json  # see config-example.json
{
  "auths": {
    "$REGISTRY_REQUIRES_LOGIN": {
      "auth": "$(echo -n $DOCKER_USERNAME:$DOCKER_PASSWORD | base64 -w 0)"
    }
  }
}
EOF

docker run \
       -ti --rm -v $(pwd):/workspace \
       -v $(pwd)/config.json:/kaniko/.docker/config.json:ro \
       gcr.io/kaniko-project/executor:v1.19.1 \
       --dockerfile=Dockerfile --destination=$DESTINATION_REQUIRES_LOGIN

docker run --pull always $DESTINATION_REQUIRES_LOGIN
# created from kaniko

#####################################################################
# Using K8s job 
#####################################################################

cat <<EOF > builder.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: image-builder
spec:
  template:
    spec:
      initContainers:
        - name: dockerfile-creator
          image: busybox
          command: ["/bin/sh", "-c"]
          args:
            - |
              echo \$DOCKERFILE > /workspace/Dockerfile
              echo \$CONFIG_JSON > /kaniko/.docker/config.json

          envs:
            - name: DOCKERFILE
              value: |
                FROM alpine
                ENTRYPOINT echo "created from kaniko, in k8s"
            - name: CONFIG_JSON
              value: |
$(cat config.json | sed 's/^/                /')
          volumeMounts:
            - name: dockerfile-volume
              mountPath: /workspace
            - name: credential-volume
              mountPath: /kaniko/.docker

      containers:
        - name: builder
          image: gcr.io/kaniko-project/executor:v1.19.1
          args:
            - --dockerfile=Dockerfile
            - --destination=$DESTINATION_REQUIRES_LOGIN
          volumeMounts:
            - name: dockerfile-volume
              mountPath: /workspace
            - name: credential-volume
              mountPath: /kaniko/.docker/config.json
              subPath: config.json

      volumes:
        - name: dockerfile-volume
          emptyDir: {}
        - name: credential-volume
          emptyDir: {}
      restartPolicy: Never
  backoffLimit: 3
EOF

docker run --pull always $DESTINATION_REQUIRES_LOGIN
# created from kaniko, in k8s
