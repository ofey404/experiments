#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://www.zenrows.com/blog/scrapy-splash#steps-to-integrate-scrapy-splash

# add sudo to get the web permission
sudo docker run -it -p 8050:8050 --rm scrapinghub/splash
# visit:
# http://0.0.0.0:8050

pip install scrapy-splash
pip install scrapy
