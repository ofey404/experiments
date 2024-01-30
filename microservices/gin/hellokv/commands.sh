#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Gin documentation (it has only a single page)
# https://github.com/gin-gonic/gin/blob/master/docs/doc.md

# Feature list:
# - [x] JSON API
# - [x] ServiceContext
# - [ ] Config File
# - [ ] Swagger API Doc
# - [ ] Request Logging
# - [ ] Validation
# - [ ] Tracing

