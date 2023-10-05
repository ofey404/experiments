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
kind create cluster -n keycloak
docker update --restart=no keycloak-control-plane

kubectl create -f https://raw.githubusercontent.com/keycloak/keycloak-quickstarts/latest/kubernetes/keycloak.yaml

# access admin console
kubectl port-forward svc/keycloak 8080:8080
# user and password:
# admin
# admin

# It has a SPA testing application
# https://www.keycloak.org/app/

# Then we can enable the user registration, and login with the new user
# https://www.baeldung.com/keycloak-user-registration

#####################################################################
# Create a client to consume it.
#####################################################################

# we created a realm called myrealm, and a client called myclient
curl -X POST http://localhost:8080/realms/myrealm/protocol/openid-connect/token \
     -d grant_type=password \
     -d client_id=myclient \
     -d username=user@example.com \
     -d password=12341234 \
     -d scope=openid \
     -d response_type=id_token
# response:
# {
#     "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ3eGszV2h6UC1hdkF4VE5nS3B6QnRvaC13MTlvak5OZnJTaG9lbHZhRVhzIn0.eyJleHAiOjE2OTY0MDQ0NzEsImlhdCI6MTY5NjQwNDE3MSwianRpIjoiMGQzMjc4NTEtMzBiNy00ODBkLWI0MzQtODA2ZGFkMGEyNTBjIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL3JlYWxtcy9teXJlYWxtIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6IjU3MjY1MTFjLTI4NDQtNDBmNi1hZDZiLTJkMjYwZTQ1MDg0MSIsInR5cCI6IkJlYXJlciIsImF6cCI6Im15Y2xpZW50Iiwic2Vzc2lvbl9zdGF0ZSI6IjAzYjNkOWZjLTVkY2QtNDI1NS04MGVhLTgzYjNlOGUxNDZjYyIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiLyoiLCJodHRwczovL3d3dy5rZXljbG9hay5vcmciXSwicmVhbG1fYWNjZXNzIjp7InJvbGVzIjpbImRlZmF1bHQtcm9sZXMtbXlyZWFsbSIsIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIiwic2lkIjoiMDNiM2Q5ZmMtNWRjZC00MjU1LTgwZWEtODNiM2U4ZTE0NmNjIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiV2Vpd2VuIENoZW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyQGV4YW1wbGUuY29tIiwiZ2l2ZW5fbmFtZSI6IldlaXdlbiIsImZhbWlseV9uYW1lIjoiQ2hlbiIsImVtYWlsIjoidXNlckBleGFtcGxlLmNvbSJ9.YE40wXG38w7Qvg2sVdjnnmDA05g8eEPL9ebfQiKe8PXMMnw46sgSWdqUt3OB71EHGyJgnmF0dHRZ_0KL13kI84Rol2SVBfHePf0tIktuAtxEDKCso6YHX7NQjXF-xNRVOUb9d9wA0PoZwwMDyvdIChy73ZQ0Y7pCfET6C3RDoOIVz60K7V34jdCmVpPfE4JzpefHL4gsuUlEE-znwc8CgJChQMjRQBgEnNXU97zup7dZ5DmJwDvUCw3qLyiKsowNQMyl3J9c62jqmODZ-rN9X4h5nyL0inDKxmfA4Pm5aa7fQYIGBtyyQ0k8On_qZeu4whC94uaC9yvewS0O4VLW3Q",
#     "expires_in": 300,
#     "refresh_expires_in": 1800,
#     "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0MGQ2MWQ0ZS01NDAxLTQyZWEtYTcwYS04MzM5MTIzYjljNTkifQ.eyJleHAiOjE2OTY0MDU5NzEsImlhdCI6MTY5NjQwNDE3MSwianRpIjoiMmRhMjdmODctNzE0NC00ZGY3LWFiZTgtNTRjNzQ2MTExMzIzIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL3JlYWxtcy9teXJlYWxtIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL3JlYWxtcy9teXJlYWxtIiwic3ViIjoiNTcyNjUxMWMtMjg0NC00MGY2LWFkNmItMmQyNjBlNDUwODQxIiwidHlwIjoiUmVmcmVzaCIsImF6cCI6Im15Y2xpZW50Iiwic2Vzc2lvbl9zdGF0ZSI6IjAzYjNkOWZjLTVkY2QtNDI1NS04MGVhLTgzYjNlOGUxNDZjYyIsInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwiLCJzaWQiOiIwM2IzZDlmYy01ZGNkLTQyNTUtODBlYS04M2IzZThlMTQ2Y2MifQ.qkeCgUB-D1BTHkd8bcvniakPl4LwI7gy93vcVyjmHXE",
#     "token_type": "Bearer",
#     "id_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ3eGszV2h6UC1hdkF4VE5nS3B6QnRvaC13MTlvak5OZnJTaG9lbHZhRVhzIn0.eyJleHAiOjE2OTY0MDQ0NzEsImlhdCI6MTY5NjQwNDE3MSwiYXV0aF90aW1lIjowLCJqdGkiOiI5M2UyMjc4OS04NGVhLTQxMjgtYWYxYi1kZjE4NGQ4ZTY1YzMiLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODAvcmVhbG1zL215cmVhbG0iLCJhdWQiOiJteWNsaWVudCIsInN1YiI6IjU3MjY1MTFjLTI4NDQtNDBmNi1hZDZiLTJkMjYwZTQ1MDg0MSIsInR5cCI6IklEIiwiYXpwIjoibXljbGllbnQiLCJzZXNzaW9uX3N0YXRlIjoiMDNiM2Q5ZmMtNWRjZC00MjU1LTgwZWEtODNiM2U4ZTE0NmNjIiwiYXRfaGFzaCI6IlEya29xeG9rOVFYUktoMTNULWxBQWciLCJhY3IiOiIxIiwic2lkIjoiMDNiM2Q5ZmMtNWRjZC00MjU1LTgwZWEtODNiM2U4ZTE0NmNjIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJuYW1lIjoiV2Vpd2VuIENoZW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJ1c2VyQGV4YW1wbGUuY29tIiwiZ2l2ZW5fbmFtZSI6IldlaXdlbiIsImZhbWlseV9uYW1lIjoiQ2hlbiIsImVtYWlsIjoidXNlckBleGFtcGxlLmNvbSJ9.Wsd5gFzW4wMkAdltJNiQyzxH1iYOzkGH1h_Ff6daf7ppAQzOPUiuy9juJiFjhlibpLnBiq5EmEH7Yx2otKhOEoQd5NnTXRL9F5E1P1ojt0fGp8fen2179k-MxrKUIYbXw7RQR9O-c84Ves7D9qUVxQVR8zc8aoKSTjAtU65khGsXYhbcwUlvO-MNbVliCcuKG0F2yC-6AypQSAB9s6WY905JVcK8PhNRKFBEIbDF7z1SqHi621dXBKUxY_xCBH8gjK_-VDJg0HnaK0sy5UqUW46nzQP2okh6200IULx-GYIPz7eH2YFIW_REn2kciGLhnCnofG1sVR0MucBLl4QfGg",
#     "not-before-policy": 0,
#     "session_state": "03b3d9fc-5dcd-4255-80ea-83b3e8e146cc",
#     "scope": "openid profile email"
# }

curl http://localhost:8080/realms/myrealm/.well-known/openid-configuration
# {
#     "issuer": "http://localhost:8080/realms/myrealm",
#     "authorization_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/auth",
#     "token_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/token",
#     "introspection_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/token/introspect",
#     "userinfo_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/userinfo",
#     "end_session_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/logout",
#     "frontchannel_logout_session_supported": true,
#     "frontchannel_logout_supported": true,
#     "jwks_uri": "http://localhost:8080/realms/myrealm/protocol/openid-connect/certs",
#     "check_session_iframe": "http://localhost:8080/realms/myrealm/protocol/openid-connect/login-status-iframe.html",
#     "grant_types_supported": [
#         "authorization_code",
#         "implicit",
#         "refresh_token",
#         "password",
#         "client_credentials",
#         "urn:ietf:params:oauth:grant-type:device_code",
#         "urn:openid:params:grant-type:ciba"
#     ],
#     "acr_values_supported": [
#         "0",
#         "1"
#     ],
#     "response_types_supported": [
#         "code",
#         "none",
#         "id_token",
#         "token",
#         "id_token token",
#         "code id_token",
#         "code token",
#         "code id_token token"
#     ],
#     "subject_types_supported": [
#         "public",
#         "pairwise"
#     ],
#     "id_token_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512"
#     ],
#     "id_token_encryption_alg_values_supported": [
#         "RSA-OAEP",
#         "RSA-OAEP-256",
#         "RSA1_5"
#     ],
#     "id_token_encryption_enc_values_supported": [
#         "A256GCM",
#         "A192GCM",
#         "A128GCM",
#         "A128CBC-HS256",
#         "A192CBC-HS384",
#         "A256CBC-HS512"
#     ],
#     "userinfo_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512",
#         "none"
#     ],
#     "userinfo_encryption_alg_values_supported": [
#         "RSA-OAEP",
#         "RSA-OAEP-256",
#         "RSA1_5"
#     ],
#     "userinfo_encryption_enc_values_supported": [
#         "A256GCM",
#         "A192GCM",
#         "A128GCM",
#         "A128CBC-HS256",
#         "A192CBC-HS384",
#         "A256CBC-HS512"
#     ],
#     "request_object_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512",
#         "none"
#     ],
#     "request_object_encryption_alg_values_supported": [
#         "RSA-OAEP",
#         "RSA-OAEP-256",
#         "RSA1_5"
#     ],
#     "request_object_encryption_enc_values_supported": [
#         "A256GCM",
#         "A192GCM",
#         "A128GCM",
#         "A128CBC-HS256",
#         "A192CBC-HS384",
#         "A256CBC-HS512"
#     ],
#     "response_modes_supported": [
#         "query",
#         "fragment",
#         "form_post",
#         "query.jwt",
#         "fragment.jwt",
#         "form_post.jwt",
#         "jwt"
#     ],
#     "registration_endpoint": "http://localhost:8080/realms/myrealm/clients-registrations/openid-connect",
#     "token_endpoint_auth_methods_supported": [
#         "private_key_jwt",
#         "client_secret_basic",
#         "client_secret_post",
#         "tls_client_auth",
#         "client_secret_jwt"
#     ],
#     "token_endpoint_auth_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512"
#     ],
#     "introspection_endpoint_auth_methods_supported": [
#         "private_key_jwt",
#         "client_secret_basic",
#         "client_secret_post",
#         "tls_client_auth",
#         "client_secret_jwt"
#     ],
#     "introspection_endpoint_auth_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512"
#     ],
#     "authorization_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512"
#     ],
#     "authorization_encryption_alg_values_supported": [
#         "RSA-OAEP",
#         "RSA-OAEP-256",
#         "RSA1_5"
#     ],
#     "authorization_encryption_enc_values_supported": [
#         "A256GCM",
#         "A192GCM",
#         "A128GCM",
#         "A128CBC-HS256",
#         "A192CBC-HS384",
#         "A256CBC-HS512"
#     ],
#     "claims_supported": [
#         "aud",
#         "sub",
#         "iss",
#         "auth_time",
#         "name",
#         "given_name",
#         "family_name",
#         "preferred_username",
#         "email",
#         "acr"
#     ],
#     "claim_types_supported": [
#         "normal"
#     ],
#     "claims_parameter_supported": true,
#     "scopes_supported": [
#         "openid",
#         "offline_access",
#         "microprofile-jwt",
#         "phone",
#         "web-origins",
#         "roles",
#         "profile",
#         "address",
#         "email",
#         "acr"
#     ],
#     "request_parameter_supported": true,
#     "request_uri_parameter_supported": true,
#     "require_request_uri_registration": true,
#     "code_challenge_methods_supported": [
#         "plain",
#         "S256"
#     ],
#     "tls_client_certificate_bound_access_tokens": true,
#     "revocation_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/revoke",
#     "revocation_endpoint_auth_methods_supported": [
#         "private_key_jwt",
#         "client_secret_basic",
#         "client_secret_post",
#         "tls_client_auth",
#         "client_secret_jwt"
#     ],
#     "revocation_endpoint_auth_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "HS256",
#         "HS512",
#         "ES256",
#         "RS256",
#         "HS384",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512"
#     ],
#     "backchannel_logout_supported": true,
#     "backchannel_logout_session_supported": true,
#     "device_authorization_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/auth/device",
#     "backchannel_token_delivery_modes_supported": [
#         "poll",
#         "ping"
#     ],
#     "backchannel_authentication_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/ext/ciba/auth",
#     "backchannel_authentication_request_signing_alg_values_supported": [
#         "PS384",
#         "ES384",
#         "RS384",
#         "ES256",
#         "RS256",
#         "ES512",
#         "PS256",
#         "PS512",
#         "RS512"
#     ],
#     "require_pushed_authorization_requests": false,
#     "pushed_authorization_request_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/ext/par/request",
#     "mtls_endpoint_aliases": {
#         "token_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/token",
#         "revocation_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/revoke",
#         "introspection_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/token/introspect",
#         "device_authorization_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/auth/device",
#         "registration_endpoint": "http://localhost:8080/realms/myrealm/clients-registrations/openid-connect",
#         "userinfo_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/userinfo",
#         "pushed_authorization_request_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/ext/par/request",
#         "backchannel_authentication_endpoint": "http://localhost:8080/realms/myrealm/protocol/openid-connect/ext/ciba/auth"
#     }
# }
