#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# port assignment in ingress gateway
kind create cluster -n ssh-multiplex
docker update --restart=no ssh-multiplex-control-plane

# dump the demo profile, check 31400 of gateway is used as TCP port
istioctl profile dump demo > istio-based-on-demo.yaml

istioctl install --set profile=demo -y

#####################################################################
# Step 1: ssh into the pod
#####################################################################

kubectl apply -f 1-ssh-to-pod.yaml

kubectl port-forward svc/istio-ingressgateway -n istio-system 31400:31400
ssh username@localhost -p 31400
# Welcome to OpenSSH Server
# ssh-multiplex:~$ 

kubectl delete -f 1-ssh-to-pod.yaml

#####################################################################
# Step 2: ssh over http (unsuceessful)
#####################################################################

kubectl apply -f 2-ssh-over-http.yaml 

kubectl port-forward svc/istio-ingressgateway -n istio-system 80:80

ssh -o ProxyCommand='curl --proxy http://localhost:8888 --proxytunnel -T - %h:%p' username@localhost -p 80
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
#   0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0curl: (56) Proxy CONNECT aborted
# kex_exchange_identification: Connection closed by remote host
# Connection closed by UNKNOWN port 65535

tinyproxy -d -c tinyproxy.conf
# verify it works
curl -x localhost:8888 google.com

ssh -o ProxyCommand='curl --proxy http://localhost:8888 --proxytunnel -T - %h:%p' username@localhost -p 80
#   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
#                                  Dload  Upload   Total   Spent    Left  Speed
#   0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
# kex_exchange_identification: Connection closed by remote host
# Connection closed by UNKNOWN port 65535

ssh -o ProxyCommand='nc -x localhost:8888 %h %p' username@localhost -p 80

#####################################################################
# Step 3: chisel
#####################################################################

# If the connection is really restricted to pure http, httptunnel is meant to
# tunnel TCP connection through HTTP requests.
# https://unix.stackexchange.com/questions/243565/how-can-i-reach-a-remote-ssh-server-through-my-http-proxy-80-port
#
# https://github.com/jpillora/chisel

go install github.com/jpillora/chisel@latest

kubectl apply -f 1-ssh-to-pod.yaml 
ssh username@localhost -p 31400
# Welcome to OpenSSH Server

chisel server --port 8888 --proxy tcp://localhost:31400
# 2023/11/27 13:43:58 server: Fingerprint IezjYKGwI9G82as9gJhnfW/1qtd0N3yK2HX/5Mw1Fq4=
# 2023/11/27 13:43:58 server: Reverse proxy enabled
# 2023/11/27 13:43:58 server: Listening on http://0.0.0.0:8888

ssh -o ProxyCommand='chisel client localhost:8888 stdio:%h:%p' username@localhost -p 31400
# Welcome to OpenSSH Server
