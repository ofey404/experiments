#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# For diagrams:
#
# https://via.placeholder.com/1920x1080


# API:
#
# https://jsonplaceholder.typicode.com/

curl https://jsonplaceholder.typicode.com/todos/1
# {
#   "userId": 1,
#   "id": 1,
#   "title": "delectus aut autem",
#   "completed": false
# }

curl https://jsonplaceholder.typicode.com/users/2
# {
#   "id": 2,
#   "name": "Ervin Howell",
#   "username": "Antonette",
#   "email": "Shanna@melissa.tv",
#   "address": {
#     "street": "Victor Plains",
#     "suite": "Suite 879",
#     "city": "Wisokyburgh",
#     "zipcode": "90566-7771",
#     "geo": {
#       "lat": "-43.9509",
#       "lng": "-34.4618"
#     }
#   },
#   "phone": "010-692-6593 x09125",
#   "website": "anastasia.net",
#   "company": {
#     "name": "Deckow-Crist",
#     "catchPhrase": "Proactive didactic contingency",
#     "bs": "synergize scalable supply-chains"
#   }
# }