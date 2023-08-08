#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# Download secrets from Kubernetes
#
# See:
# https://writeitdifferently.com/kubernetes/2020/02/26/download-secrets-from-kubernetes.html

namespace=$1
secret_name=$2
directory_to_save=${3-$2}

mkdir -p $directory_to_save

values=$(kubectl --namespace $namespace get secrets $secret_name -o json \
    | jq -r '.data | keys[] as $k | "\($k):\(.[$k])"')
for file_content in $values
do
    file_name=$(echo $file_content | cut -d':' -f1)
    echo $file_content | cut -d':' -f2 | base64 --decode > $directory_to_save/$file_name
    echo "Created $directory_to_save/$file_name"
done
