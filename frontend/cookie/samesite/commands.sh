#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Some articles explaining the SameSite attribute:
#
# https://web.dev/articles/samesite-cookies-explained
# https://www.ruanyifeng.com/blog/2019/09/cookie-samesite.html

go run cookie-backend/main.go 
# Starting server at :8080

# first we check the cookie with curl

curl -v localhost:8080/api/getcookie
# < HTTP/1.1 200 OK
# < Set-Cookie: myCookieKey=myCookieValue; SameSite=Strict

curl localhost:8080/api/printcookie
# http: named cookie not present

curl localhost:8080/api/printcookie --cookie "myCookieKey=myCookieValue; SameSite=Strict"
# Get Cookie: myCookieKey=myCookieValue

# then we try in the browser
cd cookie-frontend
npm start
