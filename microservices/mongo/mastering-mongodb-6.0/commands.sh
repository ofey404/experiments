#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# a persistent test environment
docker run -it --rm --name mastering-mongo \
           -p 27017:27017 \
           -e MONGO_INITDB_ROOT_USERNAME=root \
           -e MONGO_INITDB_ROOT_PASSWORD=password \
           -v $(pwd)/data/db:/data/db \
           mongo:7.0.2

# The connection string
mongosh mongodb://root:password@localhost:27017

#####################################################################
# Use database other than `admin`
#####################################################################

# Option 1: Create the user for `movies` database
mongosh mongodb://root:password@localhost:27017/admin
# use movies
# db.createUser({ user: 'new_user', pwd: 'new_password', roles: [{ role: 'readWrite', db: 'movies' }] })

# Option 2: 
mongosh -u root -p password --authenticationDatabase admin localhost:27017/movies

mongosh -u root -p password --authenticationDatabase admin --eval "
    use('movies');
    db.movies.insertMany( [
    {
        title: 'Titanic',
        year: 1997,
        genres: [ 'Drama', 'Romance' ]
    },
    {
        title: 'Spirited Away',
        year: 2001,
        genres: [ 'Animation', 'Adventure', 'Family' ]
    },
    {
        title: 'Casablanca',
        genres: [ 'Drama', 'Romance', 'War' ]
    }
    ] )
" localhost:27017

mongosh -u root -p password --authenticationDatabase admin \
        --file scripts/loadMovies.js

mongosh -u root -p password --authenticationDatabase admin \
        --file scripts/bulkInsert.js