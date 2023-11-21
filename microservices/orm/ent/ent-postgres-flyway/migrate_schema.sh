#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# CHANGE THIS: If we move the script.
SERVICE_ROOT=$SCRIPT_DIR

cd "$SERVICE_ROOT"

# Check if the migration name argument is provided
if [ -z "${1:-}" ]; then
  echo "Usage: $0 <migration_name>"
  echo "Please provide the name of the migration as the first argument."
  exit 1
fi

echo "Generating schema in $(pwd)/ent"
go generate ./ent

MIGRATION_SQL_PATH=$(pwd)/ent/migrate/migrations/postgresql
echo "Generating schema migration in $MIGRATION_SQL_PATH"
go run -mod=mod ent/migrate/main.go "$1"

# Extract the highest timestamp of version file.
# Files: V20231121055737__create_users.sql  V20231121060516__user_add_name_age.sql
# Print: 20231121060516
get_highest_version() {
  local highest_version_file
  highest_version_file=$(find "$MIGRATION_SQL_PATH" -name "*.sql" -printf "%f\n" | sort -V | tail -n 1)

  # Get the {} part => V{20231121055737}__create_users.sql
  timestamp=$(echo "$highest_version_file" | cut -d'_' -f 1 | cut -c 2-)

  echo "$timestamp"
}

VERSION=$(get_highest_version)

echo "Latest version $VERSION, files:"
ls "$MIGRATION_SQL_PATH" | grep "$VERSION"

echo "Write version $VERSION to ent/version.go"
cat <<EOF > ent/version.go
package ent

const (
	FlywaySchemaVersion = "$VERSION"
)
EOF