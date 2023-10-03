#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# currently it's 1.27.3
kind create cluster -n from-kubeflow
docker update --restart=no from-kubeflow-control-plane

kubectl apply -k kustomization
kubectl apply -f nginx-test-application.yaml
kubectl apply -f virtualservice.yaml # Or the /authservice endpoint won't be exposed.

kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

curl localhost:8080/nginx

kubectl port-forward svc/nginx -n nginx 8080:80

kubectl apply -f request-visualizer.yaml
# 127.0.0.6 - - [03/Oct/2023 03:57:18] "GET / HTTP/1.1" 200 -
# INFO:root:GET request,
# Path: /
# Headers:
# host: localhost:8080
# cache-control: max-age=0
# upgrade-insecure-requests: 1
# user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36 Edg/117.0.2045.43
# accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7
# sec-fetch-site: same-origin
# sec-fetch-mode: navigate
# sec-fetch-user: ?1
# sec-fetch-dest: document
# sec-ch-ua: "Microsoft Edge";v="117", "Not;A=Brand";v="8", "Chromium";v="117"
# sec-ch-ua-mobile: ?0
# sec-ch-ua-platform: "Windows"
# referer: http://localhost:8080/dex/auth/local/login?back=&state=oejhs4au2cm7zmd7sstsrxr6y
# accept-encoding: gzip, deflate, br
# accept-language: en-US,en;q=0.9
# cookie: authservice_session=MTY5NjMwNTQ2NHxOd3dBTkVGV1FUUklNMGhQV2pWRFdWWkJSMHd6UzBGRlUxTTBOVkZTTkZwWFJEVkNSRTVZV0ROVVdqTlFTelpPTWt4RlRsSlRVbEU9fIgxhmv8waEJTjMAac25WR62KPPTtivSs6reQujRwipa
# x-forwarded-for: 10.244.0.12
# x-forwarded-proto: http
# x-request-id: 7c19b35e-09c8-4564-9160-37ba7057b220
# kubeflow-userid: user@example.com
# x-forwarded-host: localhost:8080
# x-envoy-attempt-count: 1
# x-envoy-original-path: /request-visualizer
# x-envoy-internal: true
# x-forwarded-client-cert: By=spiffe://cluster.local/ns/request-visualizer/sa/default;Hash=6338de37c97a3f62c68aa777c6b046edb19b5350310404c53ae201a5859a5a03;Subject="";URI=spiffe://cluster.local/ns/istio-system/sa/istio-ingressgateway-service-account
