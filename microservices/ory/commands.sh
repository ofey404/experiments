#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#####################################################################
# ory/kratos
# docker compose playground
# https://www.ory.sh/docs/kratos/quickstart#clone-ory-kratos-and-run-it-in-docker
#####################################################################

cd ~
git clone https://github.com/ory/kratos.git
cd kratos
git checkout v1.0.0
docker-compose -f quickstart.yml -f quickstart-standalone.yml up --build --force-recreate

#####################################################################
# ory/hydra
# Follow this guide:
# https://www.ory.sh/docs/hydra/5min-tutorial
#####################################################################

cd ~
git clone git@github.com:ory/hydra.git
cd hydra
docker-compose -f quickstart.yml up --build
docker-compose -f quickstart.yml exec hydra \
    hydra create client \
    --endpoint http://127.0.0.1:4445/ \
    --format json \
    --grant-type client_credentials

# {
#     "client_id": "a605f89a-cbb1-461b-9fd3-7ca0b55da915",
#     "client_name": "",
#     "client_secret": "C.KBUjt5CMZxO.ERawmZej1oVM",
#     "client_secret_expires_at": 0,
#     "client_uri": "",
#     "created_at": "2023-10-09T02:55:59Z",
#     "grant_types": [
#         "client_credentials"
#     ],
#     "jwks": {},
#     "logo_uri": "",
#     "metadata": {},
#     "owner": "",
#     "policy_uri": "",
#     "registration_access_token": "ory_at__yCVWEkrGBc0zNSzsUUsBftUyVwXImZGoB7R3jFFjys.nXm_9e4BoLHV-dt9jUM8m1HUl5_4XCm2JwlDkXzevfI",
#     "registration_client_uri": "http://127.0.0.1:4444/oauth2/register/a605f89a-cbb1-461b-9fd3-7ca0b55da915",
#     "request_object_signing_alg": "RS256",
#     "response_types": [
#         "code"
#     ],
#     "scope": "offline_access offline openid",
#     "skip_consent": false,
#     "subject_type": "public",
#     "token_endpoint_auth_method": "client_secret_basic",
#     "tos_uri": "",
#     "updated_at": "2023-10-09T02:55:58.880845Z",
#     "userinfo_signed_response_alg": "none"
# }

client_id=a605f89a-cbb1-461b-9fd3-7ca0b55da915
client_secret=C.KBUjt5CMZxO.ERawmZej1oVM
docker-compose -f quickstart.yml exec hydra \
  hydra perform client-credentials \
  --endpoint http://127.0.0.1:4444/ \
  --client-id "$client_id" \
  --client-secret "$client_secret"
# ACCESS TOKEN    ory_at_O8eqK53lhKI31zfxwDzrmN0IjYP61cUCGc19iAwracI.L3giwfiOl--TTRHNG0TcFlsBNLk87ArQHli12TwOgL4

access_token=ory_at_O8eqK53lhKI31zfxwDzrmN0IjYP61cUCGc19iAwracI.L3giwfiOl--TTRHNG0TcFlsBNLk87ArQHli12TwOgL4
docker-compose -f quickstart.yml exec hydra \
  hydra introspect token \
  --format json-pretty \
  --endpoint http://127.0.0.1:4445/ \
  $access_token
# {
#   "active": true,
#   "client_id": "a605f89a-cbb1-461b-9fd3-7ca0b55da915",
#   "exp": 1696823942,
#   "iat": 1696820342,
#   "iss": "http://127.0.0.1:4444",
#   "nbf": 1696820342,
#   "sub": "a605f89a-cbb1-461b-9fd3-7ca0b55da915",
#   "token_type": "Bearer",
#   "token_use": "access_token"
# }

docker-compose -f quickstart.yml exec hydra \
    hydra create client \
    --endpoint http://127.0.0.1:4445 \
    --grant-type authorization_code,refresh_token \
    --response-type code,id_token \
    --format json \
    --scope openid --scope offline \
    --redirect-uri http://127.0.0.1:5555/callback
# {
#     "client_id": "a512db9c-0b13-4efc-9747-c91032be27c3",
#     "client_name": "",
#     "client_secret": "Re9YtsuLWPZOROnNEVvXtZL.m0",
#     "client_secret_expires_at": 0,
#     "client_uri": "",
#     "created_at": "2023-10-09T03:08:10Z",
#     "grant_types": [
#         "authorization_code",
#         "refresh_token"
#     ],
#     "jwks": {},
#     "logo_uri": "",
#     "metadata": {},
#     "owner": "",
#     "policy_uri": "",
#     "redirect_uris": [
#         "http://127.0.0.1:5555/callback"
#     ],
#     "registration_access_token": "ory_at_7YKFr9qfWJjVksUKrpoGoIX-nozMHQF8OhXnSZTmsCw.vPewdVKpzzR0HeEFxv0LL3IPR575_930RfNPMOIuURU",
#     "registration_client_uri": "http://127.0.0.1:4444/oauth2/register/a512db9c-0b13-4efc-9747-c91032be27c3",
#     "request_object_signing_alg": "RS256",
#     "response_types": [
#         "code",
#         "id_token"
#     ],
#     "scope": "openid offline",
#     "skip_consent": false,
#     "subject_type": "public",
#     "token_endpoint_auth_method": "client_secret_basic",
#     "tos_uri": "",
#     "updated_at": "2023-10-09T03:08:10.500445Z",
#     "userinfo_signed_response_alg": "none"
# }

code_client_id=a512db9c-0b13-4efc-9747-c91032be27c3
code_client_secret=Re9YtsuLWPZOROnNEVvXtZL.m0
docker-compose -f quickstart.yml exec hydra \
    hydra perform authorization-code \
    --client-id $code_client_id \
    --client-secret $code_client_secret \
    --endpoint http://127.0.0.1:4444/ \
    --port 5555 \
    --scope openid --scope offline