#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://openapi.moomoo.com/moomoo-api-doc/intro/intro.html
# 
# 1. Start moomoo OpenD on localhost port 11111
#    In WSL, plz use OpenD for Ubuntu. Process on host machine would cause network issue.

# 2. Optional: Install TA-Lib, https://ta-lib.org/
cd /tmp
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib-0.4.0-src.tar.gz

./configure
make
sudo make install

# Then the python wrapper could be installed
pip install -r requirements.txt
# Installing collected packages: TA-Lib, simplejson, PyCryptodome, protobuf, moomoo-api

python gettingstarted.py
# (0, 100, [])
