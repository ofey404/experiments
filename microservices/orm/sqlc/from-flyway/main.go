package main

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/ofey404/experiments/microservices/orm/sqlc/from-flyway/modelv005"
	"github.com/zeromicro/go-zero/core/logx"

	_ "github.com/lib/pq"
)

func main() {
	ctx := context.Background()
	db, err := ConnectToDb()
	logx.Must(err)

	version, err := modelv005.New(db).GetSchemaVersion(ctx)
	logx.Must(err)

	fmt.Printf("schema version: %d\n", version)
}

func ConnectToDb() (*sql.DB, error) {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		"localhost", 5432, "postgres", "mysecretpassword", "mydatabase")

	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		return nil, err
	}

	err = db.Ping()
	if err != nil {
		return nil, err
	}

	fmt.Println("Successfully connected!")
	return db, nil
}
