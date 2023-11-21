//go:build ignore

package main

import (
	"ariga.io/atlas/sql/sqltool"
	"context"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/sql/schema"
	_ "github.com/lib/pq"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/ent/migrate"
	"log"
	"os"
	"strings"
)

var schemaList = []struct {
	Directory   string
	Opts        []schema.MigrateOption
	Url         string
	OnConnError string
}{
	{
		Directory: "ent/migrate/migrations",
		Opts: []schema.MigrateOption{
			schema.WithMigrationMode(schema.ModeReplay), // provide migration mode
			schema.WithDialect(dialect.Postgres),        // Ent dialect to use
		},
		Url: "postgres://postgres:pass@localhost:5432/migration?sslmode=disable",
		OnConnError: `require a local postgres server running on port 5432.
to start a postgres server using docker, run:
  docker run --name migration -it --rm -p 5432:5432 -e POSTGRES_PASSWORD=pass -e POSTGRES_DB=migration postgres
`,
	},
}

func main() {
	ctx := context.Background()
	for _, s := range schemaList {
		// Create a local migration directory able to understand Flyway migration file format for replay.
		dir, err := sqltool.NewFlywayDir(s.Directory)
		if err != nil {
			if strings.Contains(err.Error(), "no such file or directory") {
				os.Mkdir(s.Directory, 0755)
				// continue
			} else {
				log.Fatalf("failed creating atlas migration directory: %v", err)
			}
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
