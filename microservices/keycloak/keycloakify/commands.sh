#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# follow this guide:
# microservices/keycloak/istio-oidc-authservice/commands.sh

# But downgrade to keycloak 21
kubectl apply -f keycloak.yaml 

# Check the login page, the /nginx and /request-visualizer example app
# make sure after downgrade they still work as usual

cd ~
git clone git@github.com:keycloakify/keycloakify-starter.git
cd keycloakify-starter
yarn 
yarn build-keycloak-theme
# output: ./build_keycloak/target/keycloakify-starter-keycloak-theme-4.7.3.jar
# cp to jar/keycloakify-starter-keycloak-theme-4.7.3.jar

#####################################################################
# Copy raw jar into pod
# (Unsuccessful, no `tar` exectable in the pod)
#####################################################################

keycloak_pod=keycloak-5dd799f645-zzr5z
kubectl cp jar/keycloakify-starter-keycloak-theme-4.7.3.jar \
           $keycloak_pod:/opt/keycloak/providers/keycloakify-starter-keycloak-theme-4.7.3.jar \
           -c keycloak

# ssh into the pod
/opt/keycloak/bin/kc.sh build

#####################################################################
# Build a custom binary
#####################################################################

docker build . -t keycloak:21.1.2-with-custom-theme
kind load docker-image keycloak:21.1.2-with-custom-theme -n keycloak-istio
kubectl apply -f keycloak-custom-theme.yaml 
