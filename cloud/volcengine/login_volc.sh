#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

echo "$VOLC_DOCKER_REGISTRY_PASSWORD" \
| docker login --username="$VOLC_DOCKER_REGISTRY_USERNAME" \
            --password-stdin \
            $VOLC_REGISTRY_URL

echo "## user $VOLC_DOCKER_REGISTRY_USERNAME logined to $VOLC_REGISTRY_URL"
