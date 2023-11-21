package main

import (
	"context"
	"fmt"
	"github.com/ofey404/experiments/microservices/orm/ent/versioned-migration/ent"
	"github.com/ofey404/experiments/microservices/orm/ent/versioned-migration/ent/user"
	"github.com/zeromicro/go-zero/core/logx"
	"log"

	_ "github.com/lib/pq"
)

func main() {
	client, err := ent.Open("postgres", "postgres://postgres:mysecretpassword@localhost:5432/test?sslmode=disable")
	if err != nil {
		log.Fatalf("failed opening connection to sqlite: %v", err)
	}

	defer client.Close()

	ctx := context.Background()
	_, err = CreateUser(ctx, client)
	logx.Must(err)

	_, err = QueryUser(ctx, client)
	logx.Must(err)
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
