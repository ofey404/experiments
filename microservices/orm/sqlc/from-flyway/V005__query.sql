-- name: GetEmail :one
SELECT * FROM public.email
WHERE email_id = $1 LIMIT 1;
