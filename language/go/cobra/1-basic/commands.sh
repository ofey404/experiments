#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/spf13/cobra
# User Guide: https://github.com/spf13/cobra/blob/main/site/content/user_guide.md

go get -u github.com/spf13/cobra@latest

go run . 
# Hello from myapp!
# Count: 1
# Name: World

# pass flag
go run . --count 10
# Hello from myapp!
# Count: 10
# Name: World

go run . --help
# A longer description that spans multiple lines and likely contains
# examples and usage of using your application.
# 
# Usage:
#   myapp [flags]
#   myapp [command]
# 
# Available Commands:
#   completion  Generate the autocompletion script for the specified shell
#   echo        Echo anything to the screen
#   help        Help about any command
#   version     Print the version number of myapp
# 
# Flags:
#   -c, --count int     Number of times to repeat (default 1)
#   -h, --help          help for myapp
#   -n, --name string   Name to greet (default "World")
#   -v, --verbose       Enable verbose output
# 
# Use "myapp [command] --help" for more information about a command.

go run . version
# myapp v1.0

go run . echo
# Error: requires at least 1 arg(s), only received 0
# Usage:
#   myapp echo [string to echo] [flags]
# 
# Flags:
#   -h, --help   help for echo
# 
# requires at least 1 arg(s), only received 0
# exit status 1
