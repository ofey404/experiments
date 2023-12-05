#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://www.envoyproxy.io/

docker run -it --rm envoyproxy/envoy:debug-v1.28.0 --version
# envoy  version: b5ca88acee3453c9459474b8f22215796eff4dde/1.28.0/Clean/RELEASE/BoringSSL

# see what's inside the container
docker run -it --rm envoyproxy/envoy:debug-v1.28.0 --help
docker run -it --rm envoyproxy/envoy:debug-v1.28.0 /bin/bash

# envoy-default.yaml is the default config
code --diff envoy-demo.yaml envoy-default.yaml
# we can see it adds some access_log to the default config

docker run -it --rm -p 10000:10000 \
           -v $(pwd)/envoy-demo.yaml:/etc/envoy/envoy.yaml \
           envoyproxy/envoy:debug-v1.28.0
curl -v localhost:10000

# admin interface at http://localhost:9901
# More to see https://www.envoyproxy.io/docs/envoy/latest/start/quick-start/admin#start-quick-start-admin
docker run -it --rm -p 10000:10000 -p 9901:9901 envoyproxy/envoy:debug-v1.28.0

# merge the config via command line
docker run -it --rm -p 10000:10000 -p 9901:9901 \
           -v $(pwd)/envoy-demo.yaml:/etc/envoy/envoy.yaml \
           -v $(pwd)/envoy-override.yaml:/etc/envoy/envoy-override.yaml \
           envoyproxy/envoy:debug-v1.28.0 --config-yaml '
admin:
  address:
    socket_address:
      address: 127.0.0.1
      port_value: 9902
'

# validate mode
docker run -it --rm -p 10000:10000 -p 9901:9901 envoyproxy/envoy:debug-v1.28.0 --mode validate -c /etc/envoy/envoy.yaml
# configuration '/etc/envoy/envoy.yaml' OK