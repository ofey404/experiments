#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

./genkey.sh
# Generating keypair to /home/ofey/cloud-workspace/experiments/blackmagic/openssl
# Store the private key as /home/ofey/cloud-workspace/experiments/blackmagic/openssl/private_key.pem
# ...+..+......+.+........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*......+.....+....+..+..................+...+...............+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*....+.....+......+...+.......+.....+.......+...+.....+.........+...+.+..+..........+..................+.....+......+..........+...+.....+......+.......+.................+.......+..............+.+......+..+.+..+...+.+...+.....+......+.......+...+.....+......+..........+.....+.....................+.......+..+....+......+........+.+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# ....+..+.......+......+.....+.......+..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+...+..+...+.+...+..+.........+.+......+..+...............+......+....+........+...+....+.....+..........+..+......+...+.+...+...+...+............+..+............+...+......+.+........+...+...............+.........+......+.........+...
# ......+....+.....+...............+.+.....+......+...+............+.............+...+...+.....+......+.+..+.......+.....+...+......+..........+............+..............+....+......+...+...+.....+.........+.+.
# .................+.................+...+.......+...+.........+...+..+......+......+..................+.......+.....+.+..............+.+............+.....+...+...+.+......+...+..+....+.....+.+..+.......+........+.+..+...+......+...................+........................+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Store the public key as /home/ofey/cloud-workspace/experiments/blackmagic/openssl/public_key.pem
# writing RSA key

echo -n "Hello World" |  openssl rsautl -encrypt -pubin -inkey "./public_key.pem" | base64
# The command rsautl was deprecated in version 3.0. Use 'pkeyutl' instead.
# ZAo95JzS/cbu/9jxFXehTwzBHZtB648NBu1Q8qGfMP4Om3HlfRcySM5bA+JRgKJ3w1rGJl37ZX1I
# 3UBxzl1J8MgF97OBNBXX7kWH8AH7yqvQ1JrsW+RYtMPdQbqzHc6ipew8JA4+jIFJ/rqc2dB2gS2J
# qG2covVHKSjWTycddBgNYvZlHIlFRVandRV3AJfwAOPHIp669fTmaTzgi2++F8pMdlQyjKNjK4aH
# l4FLmreRxfxVb+L8PALfwQW2z8kgvW0/KJ3G8TZA+FtPwDRzhh+xSJsQE+jNNq602dFlor35JSgl
# b6mqGDQj4ocjiLoXKBxdKJiBIbUhs+CE9i9+6w==

# Find out key length
openssl rsa -in private_key.pem -text -noout
# Private-Key: (2048 bit, 2 primes)
