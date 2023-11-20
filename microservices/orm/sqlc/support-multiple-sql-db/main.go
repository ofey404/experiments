package main

import (
	"context"
	"database/sql"
	"flag"
	"fmt"
	"github.com/zeromicro/go-zero/core/logx"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/lib/pq"
	"github.com/ofey404/experiments/microservices/orm/sqlc/support-multiple-sql-db/model"
)

var (
	connStr = flag.String("conn", "user:password@/dbname", "Connection string for the database")
	driver  = flag.String("driver", "mysql", "Database driver (mysql or postgres)")
)

func MustConnectToDb() *sql.DB {
	flag.Parse()

	db, err := sql.Open(*driver, *connStr)
	if err != nil {
		logx.Errorf("Failed to connect to db: %v", err)
		os.Exit(1)
	}

	return db
}

func main() {
	db2 := MustConnectToDb()

	q := model.New(db2)

	ctx := context.Background()

	// create author `grr martin`
	author1, err := q.CreateAuthor(ctx, model.CreateAuthorParams{
		Name:      "grr martin",
		BirthDate: sql.NullTime{Time: time.Date(1948, 9, 20, 0, 0, 0, 0, time.UTC), Valid: true},
	})
	logx.Must(err)

	// create his book `the song of ice and fire`
	_, err = q.CreateBook(ctx, model.CreateBookParams{
		Title:           "the song of ice and fire",
		PublicationDate: sql.NullTime{Time: time.Date(1996, 8, 1, 0, 0, 0, 0, time.UTC), Valid: true},
		AuthorID:        author1.ID,
	})
	logx.Must(err)

	// create author `jrr tolkien`
	author2, err := q.CreateAuthor(ctx, model.CreateAuthorParams{
		Name:      "jrr tolkien",
		BirthDate: sql.NullTime{Time: time.Date(1892, 1, 3, 0, 0, 0, 0, time.UTC), Valid: true},
	})
	logx.Must(err)

	// create book `the lord of the rings`
	_, err = q.CreateBook(ctx, model.CreateBookParams{
		Title:           "the lord of the rings",
		PublicationDate: sql.NullTime{Time: time.Date(1954, 7, 29, 0, 0, 0, 0, time.UTC), Valid: true},
		AuthorID:        author2.ID,
	})
	logx.Must(err)

	// create his book `the hobbit`
	hobbit, err := q.CreateBook(ctx, model.CreateBookParams{
		Title:           "the hobbit",
		PublicationDate: sql.NullTime{Time: time.Date(1937, 9, 21, 0, 0, 0, 0, time.UTC), Valid: true},
		AuthorID:        author2.ID,
	})
	logx.Must(err)

	// find the author of the hobbit
	hobbitAuthor, err := q.GetAuthorByID(ctx, hobbit.AuthorID)
	fmt.Printf("The author of the hobbit is: %s\n", hobbitAuthor.Name)

	// find authors born in 19 century
	authors, err := q.GetAuthorsBornWithin(ctx,
		model.GetAuthorsBornWithinParams{
			StartTime: sql.NullTime{Time: time.Date(1801, 1, 1, 0, 0, 0, 0, time.UTC), Valid: true},
			EndTime:   sql.NullTime{Time: time.Date(1900, 12, 31, 23, 59, 59, 0, time.UTC), Valid: true}},
	)
	fmt.Println("Authors born in 19th century:")
	for _, author := range authors {
		fmt.Println(author.Name)
	}
}
