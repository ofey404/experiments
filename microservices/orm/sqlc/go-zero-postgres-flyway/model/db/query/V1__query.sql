-- name: Get :one
SELECT * FROM public.hellokv
WHERE key = $1 LIMIT 1;

-- name: Set :one
INSERT INTO public.hellokv (key, value)
VALUES ($1, $2)
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;
