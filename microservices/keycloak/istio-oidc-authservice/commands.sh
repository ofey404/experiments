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

kubectl apply -f nginx-test-application.yaml

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

kubectl apply -f request-visualizer.yaml

#####################################################################
# 
#####################################################################

# Get the access token
curl -X POST http://localhost/auth/realms/myrealm/protocol/openid-connect/token \
     -d grant_type=password \
     -d client_id=myclient \
     -d username=user@example.com \
     -d password=12341234 \
     -d scope=openid \
     -d response_type=id_token

curl localhost/nginx -H "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzQjNEeVZfc08ycFItOU9MS28xSE1kR19mUDYyMFdTaTQwalVNam8td19JIn0.eyJleHAiOjE2OTY1NzI5MTksImlhdCI6MTY5NjU3MjYxOSwianRpIjoiY2ZhMjQyNWMtODk0Ny00YTA2LWFkZDktNWI3NjY1ZWE5YWUwIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdC9hdXRoL3JlYWxtcy9teXJlYWxtIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6ImE4MjRjMmM3LTFmMzUtNGM5Yi1hMWU4LTFlZDFjNmNlMmM0OSIsInR5cCI6IkJlYXJlciIsImF6cCI6Im15Y2xpZW50Iiwic2Vzc2lvbl9zdGF0ZSI6ImE0ZTdiYjg4LTkxNmUtNDJmNi05NjVhLWNiOGVlYzMyY2EzYiIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiLyoiXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImRlZmF1bHQtcm9sZXMtbXlyZWFsbSIsIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIiwic2lkIjoiYTRlN2JiODgtOTE2ZS00MmY2LTk2NWEtY2I4ZWVjMzJjYTNiIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiV2Vpd2VuIENoZW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyQGV4YW1wbGUuY29tIiwiZ2l2ZW5fbmFtZSI6IldlaXdlbiIsImZhbWlseV9uYW1lIjoiQ2hlbiIsImVtYWlsIjoidXNlckBleGFtcGxlLmNvbSJ9.sdjEpBi5Q7r6RNNL9p54YCG2IUKaL-XHoFDJ6c2mljlftsJ7CsDUycfLV0tMDI_UgwpncA7fi9qYFNdAAK1OoQWHBcnsNjPU5WSqDBpVAK4scGCDxIQO-rF01o3nk2yPIdO7_Q2OOx_jpeAIl8E9C-SDk13n8eGyIX2Cuw0O6R_FFVH_cyxB0CpbQnXMAeT7XM4fiep7ULGqeEE6suDz5nVEPW03DL6rT-4oA3RmJPpf-Wii9x1T_vNOGVZXwcgRK3WdI6azs8XwjTJOvfRtdhHin_MkCXPp3yK4LXX5UG04G1jJYgKqSoV8a0yNNlP_URbFSrYH3ewg6ejzmKfz8w","expires_in":300,"refresh_expires_in":1800,"refresh_token":"eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlMGM1MTJlMy04MzdmLTQ0ODUtYWZhYi01OWJmNGQxM2U5MGYifQ.eyJleHAiOjE2OTY1NzQ0MTksImlhdCI6MTY5NjU3MjYxOSwianRpIjoiMjZmYjg5ZWUtMmQwYS00MzgxLTgwNTMtODkzNzljZTA3MWM0IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdC9hdXRoL3JlYWxtcy9teXJlYWxtIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdC9hdXRoL3JlYWxtcy9teXJlYWxtIiwic3ViIjoiYTgyNGMyYzctMWYzNS00YzliLWExZTgtMWVkMWM2Y2UyYzQ5IiwidHlwIjoiUmVmcmVzaCIsImF6cCI6Im15Y2xpZW50Iiwic2Vzc2lvbl9zdGF0ZSI6ImE0ZTdiYjg4LTkxNmUtNDJmNi05NjVhLWNiOGVlYzMyY2EzYiIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwiLCJzaWQiOiJhNGU3YmI4OC05MTZlLTQyZjYtOTY1YS1jYjhlZWMzMmNhM2IifQ.4jrpOHJPVpSKD2DS-wFZK6NqeDANCqRuvrsNQM7IzJw","token_type":"Bearer","id_token":"eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICIzQjNEeVZfc08ycFItOU9MS28xSE1kR19mUDYyMFdTaTQwalVNam8td19JIn0.eyJleHAiOjE2OTY1NzI5MTksImlhdCI6MTY5NjU3MjYxOSwiYXV0aF90aW1lIjowLCJqdGkiOiI5ODIyNmNlZi00MTljLTRmNjUtYjFlMC01ZmQzYmE2ZDc2ZTQiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0L2F1dGgvcmVhbG1zL215cmVhbG0iLCJhdWQiOiJteWNsaWVudCIsInN1YiI6ImE4MjRjMmM3LTFmMzUtNGM5Yi1hMWU4LTFlZDFjNmNlMmM0OSIsInR5cCI6IklEIiwiYXpwIjoibXljbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiYTRlN2JiODgtOTE2ZS00MmY2LTk2NWEtY2I4ZWVjMzJjYTNiIiwiYXRfaGFzaCI6Inl4WU1TNkNqbkNYcEpNaFBZSERVR2ciLCJhY3IiOiIxIiwic2lkIjoiYTRlN2JiODgtOTE2ZS00MmY2LTk2NWEtY2I4ZWVjMzJjYTNiIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiV2Vpd2VuIENoZW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyQGV4YW1wbGUuY29tIiwiZ2l2ZW5fbmFtZSI6IldlaXdlbiIsImZhbWlseV9uYW1lIjoiQ2hlbiIsImVtYWlsIjoidXNlckBleGFtcGxlLmNvbSJ9.sAAqZtGoDSu3iHttMcypTssRwKktc4pAm3jJjlHDSPj2SBlMVum55r_5onVkwiCiS2XEnzgBqOGBsgmnC1U6433f0IkhgJdOLogchOBK0012QtO9awOO9nDJJvkak8Xekao0XnQ9f4GVhkbogEgdcK3QzpEEtpxqHhBAc0lfOFIjpvb624EHEPQ7KKhyCM99HqYl0Z_yIlkVChIub0-VwZiRXUb_HahSJLnnGxeYyDdWa2OtYJG0jAvCP1DgjlY3n71Hqpok0zEtoEBJGeNaCXYO6A5Ruk8pNXN4KFYL0W7jhL7TnqYsa7uNqvB7139Y12nigA5JKQ70NYUA36VHUg"