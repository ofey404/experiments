#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# load .env
set -o allexport; source .env; set +o allexport

echo "## load from $(pwd)/.env:"
echo "AWS_ACCOUNT_ID=${AWS_ACCOUNT_ID}"
echo "REGION=${REGION}"

if [[ -v LOGIN ]]; then
  echo "## Login AWS ECR"
  aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com
fi

REPO="playground-ticker"
TICKER_AWS_TAG="${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com/${REPO}:latest"

echo "## now we push our image to aws"
echo ${TICKER_AWS_TAG}
docker tag ticker:latest ${TICKER_AWS_TAG}
docker push ${TICKER_AWS_TAG}