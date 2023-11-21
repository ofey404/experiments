//go:build ignore

package main

import (
	"context"
	"log"
	"os"
	"strings"

	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/ent/migrate"

	"ariga.io/atlas/sql/sqltool"
	"entgo.io/ent/dialect"
	"entgo.io/ent/dialect/sql/schema"
	_ "github.com/lib/pq"
)

func main() {
	ctx := context.Background()
	// Create a local migration directory able to understand Flyway migration file format for replay.
	const migrationDirectory = "ent/migrate/migrations"
	dir, err := sqltool.NewFlywayDir(migrationDirectory)
	if err != nil {
		if strings.Contains(err.Error(), "no such file or directory") {
			os.Mkdir(migrationDirectory, 0755)
			// continue
		} else {
			log.Fatalf("failed creating atlas migration directory: %v", err)
		}
	}
	// Migrate diff options.
	opts := []schema.MigrateOption{
		schema.WithDir(dir),                         // provide migration directory
		schema.WithMigrationMode(schema.ModeReplay), // provide migration mode
		schema.WithDialect(dialect.Postgres),        // Ent dialect to use
	}
	if len(os.Args) != 2 {
		log.Fatalln("migration name is required. Use: 'go run -mod=mod ent/migrate/main.go <name>'")
	}
	// Generate migrations using Atlas support for Postgres (note the Ent dialect option passed above).
	err = migrate.NamedDiff(ctx, "postgres://postgres:pass@localhost:5432/migration?sslmode=disable", os.Args[1], opts...)
	if err != nil {
		log.Println(`require a local postgres server running on port 5432.
to start a postgres server using docker, run:
  docker run --name migration -it --rm -p 5432:5432 -e POSTGRES_PASSWORD=pass -e POSTGRES_DB=migration postgres
`)
		log.Fatalf("failed generating migration file: %v", err)
	}
}
