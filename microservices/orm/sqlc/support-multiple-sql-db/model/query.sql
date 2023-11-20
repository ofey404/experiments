-- name: GetBookByID :one
SELECT * FROM books WHERE id = $1;

-- name: GetAuthorByID :one
SELECT * FROM authors WHERE id = $1;

-- name: GetAuthorByName :one
SELECT *
FROM authors
WHERE name = $1;

-- name: GetBookByTitle :one
SELECT *
FROM books
WHERE title = $1;

-- name: GetBooksByAuthorName :many
SELECT books.*
FROM books
         JOIN authors ON books.author_id = authors.id
WHERE authors.name = $1;

-- name: GetAuthorsBornWithin :many
SELECT *
FROM authors
WHERE birth_date BETWEEN sqlc.arg(start_time) AND sqlc.arg(end_time);

-- name: CreateAuthor :one
INSERT INTO authors (name, birth_date)
VALUES ($1, $2)
RETURNING id, name, birth_date;

-- name: CreateBook :one
INSERT INTO books (title, publication_date, author_id)
VALUES ($1, $2, $3)
RETURNING id, title, publication_date, author_id;
