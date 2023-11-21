#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://entgo.io/docs/getting-started/
go run -mod=mod entgo.io/ent/cmd/ent new User

# edit schema, add field, then generate
go generate ./ent

# manage the first entity
go run .
# 2023/11/21 10:26:33 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:26:33 user returned:  User(id=1, age=30, name=a8m)

# Add Your First Edge (Relation)
go run -mod=mod entgo.io/ent/cmd/ent new Car Group

go generate ./ent

go run .
# 2023/11/21 10:33:22 user was created:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:33:22 user returned:  User(id=1, age=30, name=a8m)
# 2023/11/21 10:33:22 car was created:  Car(id=1, model=Tesla, registered_at=Tue Nov 21 10:33:22 2023)
# 2023/11/21 10:33:22 car was created:  Car(id=2, model=Ford, registered_at=Tue Nov 21 10:33:22 2023)
# 2023/11/21 10:33:22 user was created:  User(id=2, age=30, name=a8m)
# 2023/11/21 10:33:22 returned cars: [Car(id=1, model=Tesla, registered_at=Tue Nov 21 10:33:22 2023) Car(id=2, model=Ford, registered_at=Tue Nov 21 10:33:22 2023)]
# 2023/11/21 10:33:22 Car(id=2, model=Ford, registered_at=Tue Nov 21 10:33:22 2023)
