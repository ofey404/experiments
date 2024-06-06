#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# a type-checked request code demo.

npm install
npm install axios

npm run start
# { userId: 1, id: 1, title: 'delectus aut autem', completed: false }
# [
#   {
#     postId: 1,
#     id: 1,
#     name: 'id labore ex et quam laborum',
#     email: 'Eliseo@gardner.biz',
#     body: 'laudantium enim quasi est quidem magnam voluptate ipsam eos\n' +
#       'tempora quo necessitatibus\n' +
#       'dolor quam autem quasi\n' +
#       'reiciendis et nam sapiente accusantium'
#   },
#   {
#     postId: 1,
#     id: 2,
#     name: 'quo vero reiciendis velit similique earum',
#     email: 'Jayne_Kuhic@sydney.com',
#     body: 'est natus enim nihil est dolore omnis voluptatem numquam\n' +
#       'et omnis occaecati quod ullam at\n' +
#       'voluptatem error expedita pariatur\n' +
#       'nihil sint nostrum voluptatem reiciendis et'
#   }
# ]
# { title: 'foo', body: 'bar', userId: 1, id: 101 }
# { title: 'post2', body: 'bar', userId: 2, id: 101 }