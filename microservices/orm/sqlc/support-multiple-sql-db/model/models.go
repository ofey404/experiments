// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.21.0

package model

import (
	"database/sql"
)

type Author struct {
	ID        int32
	Name      string
	BirthDate sql.NullTime
}

type Book struct {
	ID              int32
	Title           string
	PublicationDate sql.NullTime
	AuthorID        int32
}
