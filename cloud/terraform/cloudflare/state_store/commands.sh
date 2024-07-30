#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Refs:
#
# Support Cloudflare r2 for storing Terraform state #33847
# https://github.com/hashicorp/terraform/issues/33847
# 
# Terraform State Management: Integrating Cloudflare R2
# https://medium.com/@GarisSpace/terraform-state-management-integrating-cloudflare-r2-b2e82798896d

## EDIT EXAMPLE MAIN.TF

# https://developer.hashicorp.com/terraform/language/settings/backends/configuration#partial-configuration
#
# use environment variable to set the credential
# https://developer.hashicorp.com/terraform/cli/config/environment-variables

terraform init
# create an empty state in the r2 bucket
terraform apply -auto-approve

# S3 API compatibility
# https://developers.cloudflare.com/r2/api/s3/api/
