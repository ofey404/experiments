#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

vcpkg install crow
vcpkg install nlohmann-json

./cmake-build-debug/crow_http_server
curl localhost:8080
# Hello from crow_http_server!

#####################################################################
# Raw parsing of POST data
#####################################################################

curl -X POST -H "Content-Type: application/json" -d '{"message":"Hello, world!"}' http://localhost:8080/json
# Received message: Hello, world!
curl -X POST -H "Content-Type: application/json" -d '{}' http://localhost:8080/json
# Bad Request: cannot find key

#####################################################################
# Parse JSON to struct with nlohmann/json.hpp
#####################################################################
curl -X POST -H "Content-Type: application/json" -d '{"name":"John", "age":30}' http://localhost:8080/json_structured
# {"age":31,"name":"John"}
curl -X POST -H "Content-Type: application/json" -d '{}' http://localhost:8080/json_structured
# Bad Request: [json.exception.out_of_range.403] key 'name' not found