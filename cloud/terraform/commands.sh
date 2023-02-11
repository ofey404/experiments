#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# installation
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

terraform init
terraform plan
terraform apply
terraform destroy
terraform init -upgrade

# this works
export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"

# this doesn't work
# export AWS_CONFIG_FILE="~/.aws/config"
# export AWS_SHARED_CREDENTIALS_FILE="~.aws/credentials"

terraform fmt
terraform validate
terraform show
terraform state list

# aws ec2 create-default-subnet --availability-zone us-west-2
# 
# or: specify a subnet id:
# subnet_id = "subnet-00bca75f854832825"
