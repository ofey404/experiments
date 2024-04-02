#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Generate Clients
#
# https://fastapi.tiangolo.com/advanced/generate-clients/
# https://openapi-generator.tech/

npm install @openapitools/openapi-generator-cli -g

openapi-generator-cli generate \
    -i openapi.json \
    -g python \
    -o ./client/python \
    --additional-properties=packageName=hello_kv_client
# generateSourceCodeOnly=true
# See all additional-properties:
# https://openapi-generator.tech/docs/generators/python/

cd client/python/
pip install -e .
cd -

# start server:
# {experiments}/microservices/fastapi/fastapi-example-project$ python main.py

python client.py 
# The response of DefaultApi->get_logic_kv_get_post:
# 
# GetResponse(key='key', value='')
