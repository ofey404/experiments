// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.21.0
// source: V1__query.sql

package modelv1

import (
	"context"
	"database/sql"
)

const get = `-- name: Get :one
SELECT key, value FROM public.hellokv
WHERE key = $1 LIMIT 1
`

func (q *Queries) Get(ctx context.Context, key string) (Hellokv, error) {
	row := q.db.QueryRowContext(ctx, get, key)
	var i Hellokv
	err := row.Scan(&i.Key, &i.Value)
	return i, err
}

const getLatestSchema = `-- name: GetLatestSchema :one
SELECT version
FROM public.flyway_schema_history
WHERE success = true
ORDER BY
    STRING_TO_ARRAY(version, '.')::INT[] DESC
LIMIT 1
`

func (q *Queries) GetLatestSchema(ctx context.Context) (sql.NullString, error) {
	row := q.db.QueryRowContext(ctx, getLatestSchema)
	var version sql.NullString
	err := row.Scan(&version)
	return version, err
}

const set = `-- name: Set :one
INSERT INTO public.hellokv (key, value)
VALUES ($1, $2)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value
RETURNING key, value
`

type SetParams struct {
	Key   string
	Value sql.NullString
}

func (q *Queries) Set(ctx context.Context, arg SetParams) (Hellokv, error) {
	row := q.db.QueryRowContext(ctx, set, arg.Key, arg.Value)
	var i Hellokv
	err := row.Scan(&i.Key, &i.Value)
	return i, err
}
