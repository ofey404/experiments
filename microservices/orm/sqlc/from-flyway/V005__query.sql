-- name: GetEmail :one
SELECT * FROM public.email
WHERE email_id = $1 LIMIT 1;

-- name: GetSchemaVersion :one
SELECT max(version)::bigint FROM public.flyway_schema_history;
