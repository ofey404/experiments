#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Troubleshooting service discovery
kubectl get deploy -n kube-system -l k8s-app=kube-dns
kubectl get pods -n kube-system -l k8s-app=kube-dns
kubectl get svc kube-dns -n kube-system

# in network-tester
nslookup kubernetes
# Server:         10.96.0.10
# Address:        10.96.0.10#53
# 
# Name:   kubernetes.default.svc.cluster.local
# Address: 10.96.0.1
cat /etc/resolv.conf 
# search default.svc.cluster.local svc.cluster.local cluster.local
# nameserver 10.96.0.10
# options ndots:5

# check resources and their groups
kubectl api-resources
# NAME                                         SHORTNAMES         APIGROUP                           NAMESPACED   KIND
# bindings                                                                                           true         Binding
# componentstatuses                            cs                                                    false        ComponentStatus
# configmaps                                   cm                                                    true         ConfigMap
# endpoints                                    ep                                                    true         Endpoints
# customresourcedefinitions                    crd,crds           apiextensions.k8s.io               false        CustomResourceDefinition
# ...

# proxy api server on localhost:9000
kubectl proxy --port 9000 

kubectl explain namespaces
# KIND:     Namespace
# VERSION:  v1
# 
# DESCRIPTION:
#      Namespace provides a scope for Names. Use of multiple namespaces is
#      optional.
# 
# FIELDS:
#      ...