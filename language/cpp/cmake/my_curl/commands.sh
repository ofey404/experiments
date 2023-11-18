#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# manually install packages
sudo apt-get install libcurl4-openssl-dev
sudo apt-get install libgtest-dev

# Or use clion
mkdir cmake-build-debug
cd cmake-build-debug
cmake ..
make

# run the outputs
./src/my_curl
# <!doctype html><html itemscope="" itemtype="http://schema.org/WebPage" lang="en-SG"><head>
# ...

# run the tests
./tests/my_curl_test
# [==========] Running 1 test from 1 test suite.
# [----------] Global test environment set-up.
# [----------] 1 test from WriteCallbackTest
# [ RUN      ] WriteCallbackTest.AppendsDataToString
# [       OK ] WriteCallbackTest.AppendsDataToString (0 ms)
#  [----------] 1 test from WriteCallbackTest (0 ms total)
#
# [----------] Global test environment tear-down
# [==========] 1 test from 1 test suite ran. (0 ms total)
# [  PASSED  ] 1 test.
