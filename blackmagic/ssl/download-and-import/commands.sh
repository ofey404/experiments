#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Download secrets from ingress-nginx
# None of them are the right one.
./download-secrets.sh kube-system general-webhook-certs
./download-secrets.sh kube-system ingress-nginx-admission

# WORKS:
# grab certificate directly from the server
echo | openssl s_client -connect IP:port 2>/dev/null | openssl x509 -noout -text
echo | openssl s_client -connect IP:port 2>/dev/null | openssl x509 > certificate.crt

# Linux distributions use a directory (/etc/ssl/certs by default) to hold trusted CA certificates.
sudo cp certificate.crt /etc/ssl/certs/disposable-$(date +%Y-%m-%d-%H-%M-%S).crt

# BE CAREFUL!
sudo cp certificate.crt /usr/local/share/ca-certificates/disposable-$(date +%Y-%m-%d-%H-%M-%S).crt
sudo update-ca-certificates

ls /usr/local/share/ca-certificates/disposable-*
