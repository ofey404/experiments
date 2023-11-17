#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# V005.sql is the full schema dumped from a running postgresql instance.
# It's the V005 schema version, managed by flyway.


# SQLC: Getting started with PostgreSQL
# https://docs.sqlc.dev/en/stable/tutorials/getting-started.html

