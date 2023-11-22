//go:build ignore

package main

import (
	"ariga.io/atlas/sql/sqltool"
	"context"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/sql/schema"
	_ "github.com/lib/pq"

	_ "github.com/go-sql-driver/mysql"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent/migrate"
	"log"
	"os"
)

var schemaList = []struct {
	Directory   string
	Opts        []schema.MigrateOption
	Url         string
	OnConnError string
}{
	{
		Directory: "internal/ent/migrate/migrations/postgresql",
		Opts: []schema.MigrateOption{
			schema.WithMigrationMode(schema.ModeReplay), // provide migration mode
			schema.WithDialect(dialect.Postgres),        // Ent dialect to use
		},
		Url: "postgres://postgres:pass@localhost:5432/migration?sslmode=disable",
		OnConnError: `require a local postgres server running on port 5432.
to start a postgres server using docker, run:
  docker run --name migration-postgres -it --rm -p 5432:5432 -e POSTGRES_PASSWORD=pass -e POSTGRES_DB=migration postgres
`,
	},
	{
		Directory: "internal/ent/migrate/migrations/mysql",
		Opts: []schema.MigrateOption{
			schema.WithMigrationMode(schema.ModeReplay), // provide migration mode
			schema.WithDialect(dialect.MySQL),           // Ent dialect to use
		},
		Url: "mysql://root:mysecretpassword@localhost:3306/migration",
		OnConnError: `require a local mysql server running on port 3306.
to start a mysql server using docker, run:
	docker run --name migration-mysql -it --rm -p 3306:3306 -e MYSQL_DATABASE=migration -e MYSQL_ROOT_PASSWORD=mysecretpassword mysql:8
`,
	},
}

func main() {
	ctx := context.Background()
	for _, s := range schemaList {
		// Create a local migration directory able to understand Flyway migration file format for replay.
		dir, err := sqltool.NewFlywayDir(s.Directory)
		if err != nil {
			log.Fatalf("failed creating atlas migration directory: %v", err)
		}
		if len(os.Args) != 2 {
			log.Fatalln("migration name is required. Use: 'go run -mod=mod ent/migrate/main.go <name>'")
		}

		s.Opts = append(s.Opts, schema.WithDir(dir))
		// Generate migrations using Atlas support for Postgres (note the Ent dialect option passed above).
		err = migrate.NamedDiff(ctx, s.Url, os.Args[1], s.Opts...)
		if err != nil {
			log.Println(s.OnConnError)
			log.Fatalf("failed generating migration file: %v", err)
		}
	}
}
