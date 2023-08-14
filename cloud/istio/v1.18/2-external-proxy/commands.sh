#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

##############################################
# 1. Access local service from kind cluster.
docker run -it --rm -p 8888:8888 hellokv:latest

# in network-tester
# We can access the host machine from host.docker.internal
curl host.docker.internal:8888/getkey
# field key is not set

##############################################
# 2. okay, let's set up a proxy
sudo apt-get install tinyproxy

tinyproxy -d -c tinyproxy.conf

# verify it works
curl -x localhost:8888 google.com

# https://istio.io/latest/docs/tasks/traffic-management/egress/http-proxy/

##############################################
# 3. Understand how egress gateway works
# Check https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/
curl -sSL -o /dev/null -D - http://edition.cnn.com/politics
kubectl apply -f network-tester.yaml
# It would do a redirect to https.
# so we add `-L` to follow redirect.
#
# ...
# HTTP/1.1 301 Moved Permanently
# ...
# location: https://edition.cnn.com/politics
# ...
# 
# HTTP/2 200
# Content-Type: text/html; charset=utf-8
# ...

# create destination rule
kubectl apply -f 1-cnn.yaml
# do it again
curl -sSL -o /dev/null -D - http://edition.cnn.com/politics
# HTTP/1.1 503 Service Unavailable
# date: Fri, 11 Aug 2023 06:38:59 GMT
# server: envoy
# x-envoy-upstream-service-time: 34
# content-length: 0

# visualize the mesh
# More to see:
# https://istio.io/latest/docs/tasks/observability/kiali/
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.18/samples/addons/kiali.yaml
PATH=$PATH:$(pwd)/../istio-1.18.2/bin
istioctl dashboard kiali

kubectl delete -f 1-cnn.yaml

##############################################
# 4. Okay finally we can redirect the traffic through the proxy
#    https://istio.io/latest/docs/tasks/traffic-management/egress/http-proxy/
cat 2-external-proxy.yaml
# In 2-external-proxy.yaml, the proxy is still not "transparent".
# we need to visit host as <my-company-proxy.com>

##############################################
# 5. Can we inject $HTTP_PROXY and $HTTPS_PROXY,
#    into sidecar as ProxyConfig?
# https://istio.io/latest/docs/reference/config/networking/proxy-config/
cat 3-ProxyConfig.yaml
# It's too hacky. we would place this method at lowest priority.
#
# Some products implements it.
# But I feel it's suspicious.
# Pod level external HTTP(S) proxy configuration with Istio | Cisco tech blog
# https://techblog.cisco.com/blog/istio-external-proxy

##############################################
# 6. Can we use service entry, to redirect
#    huggingface.com to use our http proxy?
#    So that we can do it transparently.
curl huggingface.co
# <html>
# <head><title>301 Moved Permanently</title></head>
# <body>
# <center><h1>301 Moved Permanently</h1></center>
# <hr><center>CloudFront</center>
# </body>
# </html>

# check the proxy behavior if it works
curl -x http://localhost:8888 huggingface.co
curl -x host.docker.internal:8888 huggingface.co
# In the terminal of
# tinyproxy -d -c tinyproxy.conf
# INFO      Aug 11 17:35:01.472 [560961]: No upstream proxy for huggingface.co
# INFO      Aug 11 17:35:01.472 [560961]: opensock: opening connection to huggingface.co:80
# INFO      Aug 11 17:35:01.474 [560961]: opensock: getaddrinfo returned for huggingface.co:80
# CONNECT   Aug 11 17:35:01.484 [560961]: Established connection to host "huggingface.co" using file descriptor 5.
# INFO      Aug 11 17:35:01.497 [560961]: Closed connection between local client (fd:4) and remote client (fd:5)

kubectl apply -f 4-proxy-huggingface.yaml

# IT DOESN'T WORK AS EXPECTED.


