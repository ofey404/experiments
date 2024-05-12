#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://realpython.com/modern-web-automation-with-python-and-selenium/
# Target:
# https://www.toolify.ai/new

pip install selenium

# for extra dependency
sudo apt-get install -y chromium-browser

# Well... Selenium is too heavy, and its dependency is machine specific.
# I'll try scrapy-splash.