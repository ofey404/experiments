package main

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/ofey404/experiments/microservices/flyway/helper"
	"github.com/ofey404/experiments/microservices/orm/ent/versioned-migration/internal/ent"
	"github.com/ofey404/experiments/microservices/orm/ent/versioned-migration/internal/ent/user"
	"github.com/zeromicro/go-zero/core/logx"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	dataSource := "postgres://postgres:mysecretpassword@localhost:5432/test?sslmode=disable"

	client, err := ent.Open("postgres", dataSource)
	if err != nil {
		log.Fatalf("failed opening connection to sqlite: %v", err)
	}

	defer client.Close()

	checkSchemaVersion(dataSource)

	// run options
	ctx := context.Background()
	_, err = CreateUser(ctx, client)
	logx.Must(err)

	_, err = QueryUser(ctx, client)
	logx.Must(err)
}

func checkSchemaVersion(dataSource string) {
	db, err := sql.Open("postgres", dataSource)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// Check that the database connection is good
	err = db.Ping()
	if err != nil {
		log.Fatal(err)
	}

	// Get the latest schema version
	version, err := helper.GetLatestSchema(db, helper.GetLatestSchemaOpts{DBType: helper.Postgres})
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Latest schema version:", version)

	if version != "20231121060516" {
		log.Fatalf("expected version 20231121060516, get %s", version)
	}
}

func CreateUser(ctx context.Context, client *ent.Client) (*ent.User, error) {
	u, err := client.User.
		Create().
		SetAge(30).
		SetName("a8m").
		Save(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed creating user: %w", err)
	}
	log.Println("user was created: ", u)
	return u, nil
}

func QueryUser(ctx context.Context, client *ent.Client) (*ent.User, error) {
	u, err := client.User.
		Query().
		Where(user.Name("a8m")).
		// `Only` fails if no user found,
		// or more than 1 user returned.
		Only(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed querying user: %w", err)
	}
	log.Println("user returned: ", u)
	return u, nil
}
