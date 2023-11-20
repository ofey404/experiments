-- name: Get :one
SELECT * FROM public.hellokv
WHERE key = $1 LIMIT 1;

-- name: Set :one
INSERT INTO public.hellokv (key, value)
VALUES ($1, $2)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value
RETURNING *;

-- name: GetLatestSchema :one
SELECT version
FROM public.flyway_schema_history
WHERE success = true
ORDER BY
    STRING_TO_ARRAY(version, '.')::INT[] DESC
LIMIT 1;
