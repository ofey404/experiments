#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Following this guide:
# https://www.keycloak.org/getting-started/getting-started-kube

# 1.27.3
kind create cluster -n keycloak-istio
docker update --restart=no keycloak-istio-control-plane

istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled --overwrite

kubectl apply -f gateway.yaml 
kubectl apply -f keycloak.yaml 

kubectl port-forward svc/istio-ingressgateway -n istio-system 80:80
# okay, now we can visit localhost/auth
# The `/auth` path requires special configuration in keycloak.yaml

#####################################################################
# create myrealm and myapp
#####################################################################

# Following this guide, we create a new realm, then achieve its configuration
# via the well-known endpoint:
#
# https://napo.io/posts/istio-oidc-authn--authz-with-oauth2-proxy/
kubectl apply -f ../../../snippets/network-tester.yaml 

# in the network-tester pod:
OIDC_DISCOVERY_URL="http://keycloak.default.svc.cluster.local/auth/realms/myrealm/.well-known/openid-configuration"
OIDC_DISCOVERY_URL_RESPONSE=$(curl -s $OIDC_DISCOVERY_URL)

OIDC_ISSUER_URL=$(echo $OIDC_DISCOVERY_URL_RESPONSE | jq -r .issuer)
OIDC_JWKS_URL=$(echo $OIDC_DISCOVERY_URL_RESPONSE | jq -r .jwks_uri)
OIDC_AUTH_URL=$(echo $OIDC_DISCOVERY_URL_RESPONSE | jq -r .authorization_endpoint)
OIDC_REDEEM_URL=$(echo $OIDC_DISCOVERY_URL_RESPONSE | jq -r .token_endpoint)
OIDC_PROFILE_URL=$(echo $OIDC_DISCOVERY_URL_RESPONSE | jq -r .userinfo_endpoint)

echo OIDC_ISSUER_URL = $OIDC_ISSUER_URL
echo OIDC_JWKS_URL = $OIDC_JWKS_URL
echo OIDC_AUTH_URL = $OIDC_AUTH_URL
echo OIDC_REDEEM_URL = $OIDC_REDEEM_URL
echo OIDC_PROFILE_URL = $OIDC_PROFILE_URL

# OIDC_ISSUER_URL = http://keycloak.default.svc.cluster.local/auth/realms/myrealm
# OIDC_JWKS_URL = http://keycloak.default.svc.cluster.local/auth/realms/myrealm/protocol/openid-connect/certs
# OIDC_AUTH_URL = http://keycloak.default.svc.cluster.local/auth/realms/myrealm/protocol/openid-connect/auth
# OIDC_REDEEM_URL = http://keycloak.default.svc.cluster.local/auth/realms/myrealm/protocol/openid-connect/token
# OIDC_PROFILE_URL = http://keycloak.default.svc.cluster.local/auth/realms/myrealm/protocol/openid-connect/userinfo

# LoginURL:
# http://localhost/auth/realms/myrealm/protocol/openid-connect/auth?response_type=code&client_id=myclient&redirect_uri=http://localhost:8080/authorization-code/callback
#
# More to see
# [Keycloak realm login page is not appearing](https://stackoverflow.com/questions/61858077/keycloak-realm-login-page-is-not-appearing)

#####################################################################
# use oidc-authservice
#####################################################################

kubectl apply -k oidc-authservice/

# Then visit localhost/nginx, we can see the login page. but it would block in
# the 2nd callback, the issuer is not correct.
#
# Error:
# id token issued by a different provider, expected
# "http://keycloak.default.svc.cluster.local/auth/realms/myrealm" got
# "http://localhost/auth/realms/myrealm"

# We can edit hosts file to make localhost point to keycloak.default.svc.cluster.local.
# The login process would be successful.

kubectl delete -k oidc-authservice/

#####################################################################
# use oauth2-proxy
#####################################################################

kubectl apply -k oauth2-proxy/

kubectl apply -k request-visualizer.yaml
