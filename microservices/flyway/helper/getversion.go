package helper

import (
	"database/sql"
	"errors"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/lib/pq"
)

// Database type constants
const (
	Postgres = "postgres"
	MySQL    = "mysql"
)

// GetLatestSchemaOpts defines the options for the GetLatestSchema function.
type GetLatestSchemaOpts struct {
	DBType string
}

// GetLatestSchema retrieves the latest schema version from the flyway_schema_history table.
func GetLatestSchema(db *sql.DB, opts GetLatestSchemaOpts) (string, error) {
	var version string
	var query string

	switch opts.DBType {
	case Postgres:
		query = "SELECT version FROM public.flyway_schema_history ORDER BY installed_rank DESC LIMIT 1"
	case MySQL:
		query = "SELECT version FROM flyway_schema_history ORDER BY installed_rank DESC LIMIT 1"
	default:
		return "", errors.New("unsupported database type")
	}

	err := db.QueryRow(query).Scan(&version)
	switch {
	case errors.Is(err, sql.ErrNoRows):
		return "", err
	case err != nil:
		return "", err
	default:
		return version, nil
	}
}
