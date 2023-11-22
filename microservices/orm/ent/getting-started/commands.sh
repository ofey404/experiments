#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://entgo.io/docs/getting-started/
go run -mod=mod entgo.io/ent/cmd/ent new User --target internal/ent/schema

# edit schema, add field, then generate
go generate ./internal/ent

# manage the first entity
go run .
# 2023/11/21 10:26:33 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:26:33 user returned:  User(id=1, age=30, name=a8m)

# Add Your First Edge (Relation)
go run -mod=mod entgo.io/ent/cmd/ent new Car Group --target internal/ent/schema

go generate ./internal/ent

go run .
# 2023/11/21 10:33:22 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:33:22 user returned:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:33:22 car was created:  Car(id=1, model=Tesla, registered_at=Tue Nov 21 10:33:22 2023)
# 2023/11/21 10:33:22 car was created:  Car(id=2, model=Ford, registered_at=Tue Nov 21 10:33:22 2023)
# 2023/11/21 10:33:22 user was created:  User(id=2, age=30, name=a8m)
# 2023/11/21 10:33:22 returned cars: [Car(id=1, model=Tesla, registered_at=Tue Nov 21 10:33:22 2023) Car(id=2, model=Ford, registered_at=Tue Nov 21 10:33:22 2023)]
# 2023/11/21 10:33:22 Car(id=2, model=Ford, registered_at=Tue Nov 21 10:33:22 2023)

# Add Your First Inverse Edge (BackRef)
go run .
# 2023/11/21 10:41:31 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:41:31 user returned:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:41:31 car was created:  Car(id=1, model=Tesla, registered_at=Tue Nov 21 10:41:31 2023)
# 2023/11/21 10:41:31 car was created:  Car(id=2, model=Ford, registered_at=Tue Nov 21 10:41:31 2023)
# 2023/11/21 10:41:31 user was created:  User(id=2, age=30, name=a8m)
# 2023/11/21 10:41:31 returned cars: [Car(id=1, model=Tesla, registered_at=Tue Nov 21 10:41:31 2023) Car(id=2, model=Ford, registered_at=Tue Nov 21 10:41:31 2023)]
# 2023/11/21 10:41:31 Car(id=2, model=Ford, registered_at=Tue Nov 21 10:41:31 2023)
# 2023/11/21 10:41:31 car "Tesla" owner: "a8m"
# 2023/11/21 10:41:31 car "Ford" owner: "a8m"

#####################################################################
# Visualize the Schema
#####################################################################

# install atlas
curl -sSf https://atlasgo.sh | sh
atlas version
# atlas version v0.15.1-6bd8a65-canary
# https://github.com/ariga/atlas/releases/latest

# -w would open in browser
atlas schema inspect \
  -u "ent://internal/ent/schema" \
  --dev-url "sqlite://file?mode=memory&_fk=1" \
  -w

# Generate SQL Schema
atlas schema inspect \
  -u "ent://internal/ent/schema" \
  --dev-url "sqlite://file?mode=memory&_fk=1" \
  --format '{{ sql . "  " }}'
# -- Create "cars" table
# CREATE TABLE `cars` (
#   `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
#   `model` text NOT NULL,
#   `registered_at` datetime NOT NULL,
#   `user_cars` integer NULL,
#   CONSTRAINT `cars_users_cars` FOREIGN KEY (`user_cars`) REFERENCES `users` (`id`) ON DELETE SET NULL
# );
# -- Create "groups" table
# CREATE TABLE `groups` (
#   `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
#   `name` text NOT NULL
# );
# -- Create "users" table
# CREATE TABLE `users` (
#   `id` integer NOT NULL PRIMARY KEY AUTOINCREMENT,
#   `age` integer NOT NULL,
#   `name` text NOT NULL DEFAULT ('unknown')
# );


#####################################################################
# Create Your Second Edge
#####################################################################

go run .
# 2023/11/21 11:04:17 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 11:04:17 user returned:  User(id=1, age=30, name=a8m)
# 2023/11/21 11:04:17 car was created:  Car(id=1, model=Tesla, registered_at=Tue Nov 21 11:04:17 2023)
# 2023/11/21 11:04:17 car was created:  Car(id=2, model=Ford, registered_at=Tue Nov 21 11:04:17 2023)
# 2023/11/21 11:04:17 user was created:  User(id=2, age=30, name=a8m)
# 2023/11/21 11:04:17 returned cars: [Car(id=1, model=Tesla, registered_at=Tue Nov 21 11:04:17 2023) Car(id=2, model=Ford, registered_at=Tue Nov 21 11:04:17 2023)]
# 2023/11/21 11:04:17 Car(id=2, model=Ford, registered_at=Tue Nov 21 11:04:17 2023)
# 2023/11/21 11:04:17 car "Tesla" owner: "a8m"
# 2023/11/21 11:04:17 car "Ford" owner: "a8m"
# 2023/11/21 11:04:17 The graph was created successfully
# 2023/11/21 11:04:17 cars returned: [Car(id=3, model=Tesla, registered_at=Tue Nov 21 11:04:17 2023) Car(id=4, model=Mazda, registered_at=Tue Nov 21 11:04:17 2023)]
# 2023/11/21 11:04:17 cars returned: [Car(id=3, model=Tesla, registered_at=Tue Nov 21 11:04:17 2023) Car(id=5, model=Ford, registered_at=Tue Nov 21 11:04:17 2023)]
# 2023/11/21 11:04:17 groups returned: [Group(id=1, name=GitLab) Group(id=2, name=GitHub)]
