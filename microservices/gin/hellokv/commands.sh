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
# - [ ] Structured Logging, both request log and in-logic log
# - [ ] Request Validation
# - [ ] Tracing

# Skipped feature (I know I can do these, just a matter of time):
# - [ ] Config File https://github.com/spf13/viper
# - [ ] Swagger API Doc https://github.com/swaggo/gin-swagger
