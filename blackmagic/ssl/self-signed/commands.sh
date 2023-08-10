#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# fake domain name for local testing.
export DOMAIN=my.platform.com

# create without password
openssl req -x509 -nodes -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj "/CN=$DOMAIN"

# BE CAREFUL!
sudo cp cert.pem /usr/local/share/ca-certificates/disposable-$(date +%Y-%m-%d-%H-%M-%S)-cert.pem
sudo update-ca-certificates

# run
go run main.go 
# Starting server at :443...

# cert wont work when we visit localhost
curl https://localhost:443
# curl: (60) SSL certificate problem: self-signed certificate
# More details here: https://curl.se/docs/sslcerts.html
# 
# curl failed to verify the legitimacy of the server and therefore could not
# establish a secure connection to it. To learn more about this situation and
# how to fix it, please visit the web page mentioned above.

# verify server runs
curl --insecure https://localhost:443
# Hello, you've connected successfully!

sudo vim /etc/hosts
# add this line
# 127.0.0.1       $DOMAIN

curl https://$DOMAIN:443
# curl: (60) SSL certificate problem: self-signed certificate
# More details here: https://curl.se/docs/sslcerts.html
# 
# curl failed to verify the legitimacy of the server and therefore could not
# establish a secure connection to it. To learn more about this situation and
# how to fix it, please visit the web page mentioned above.


# verify the content
cat cert.pem | openssl x509 -noout -text

# windows
# (no password)
openssl pkcs12 -export -inkey key.pem -in cert.pem -out cert.p12
