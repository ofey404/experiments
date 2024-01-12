#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

source ../env.sh

cat <<EOF > secret.yaml
apiVersion: v1
metadata:
  name: image-builder-secret
kind: Secret
type: kubernetes.io/dockerconfigjson
data:
  .dockerconfigjson: $(cat ../config.json | base64 -w 0)
EOF

cat <<EOF2 > builder.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: image-builder
spec:
  template:
    spec:
      containers:
        - name: builder
          image: gcr.io/kaniko-project/executor:v1.19.1
          args:
            - --dockerfile=Dockerfile
            - --destination=$DESTINATION_REQUIRES_LOGIN
          volumeMounts:
            - name: dockerfile-volume
              mountPath: /workspace
            - name: docker-config
              mountPath: /kaniko/.docker/
      volumes:
        - name: docker-config
          secret:
              secretName: image-builder-secret
              items:
              - key: .dockerconfigjson
                path: config.json
        - name: dockerfile-volume
          configMap:
              name: image-builder-dockerfile
              items:
              - key: Dockerfile
                path: Dockerfile
      restartPolicy: Never
  backoffLimit: 3
EOF2


cat <<EOF > configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: image-builder-dockerfile
data:
  Dockerfile: |
    FROM alpine
    ENTRYPOINT echo "created from kaniko, in k8s, with secret and dockerfile"
EOF

kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml
kubectl apply -f builder.yaml

docker run --pull always -it --rm $DESTINATION_REQUIRES_LOGIN
# created from kaniko, in k8s, with secret and dockerfile
