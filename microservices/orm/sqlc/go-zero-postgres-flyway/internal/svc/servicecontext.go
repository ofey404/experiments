package svc

import (
	"context"
	"database/sql"
	"fmt"
	"github.com/Masterminds/semver/v3"
	_ "github.com/lib/pq"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/config"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/model/modelv1"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/model/modelv2"
	"github.com/zeromicro/go-zero/core/logx"
	"os"
	"time"
)

type ServiceContext struct {
	Config  config.Config
	ModelV1 *modelv1.Queries
	ModelV2 *modelv2.Queries
}

func NewServiceContext(c config.Config) *ServiceContext {
	db, err := ConnectToDb()
	logx.Must(err)
	svcCtx := &ServiceContext{
		Config: c,
	}
	if c.SchemaVersion == config.SchemaVersionV1 {
		model := modelv1.New(db)
		MustVerifySchema(model)
		svcCtx.ModelV1 = model
	} else if c.SchemaVersion == config.SchemaVersionV2 {
		model := modelv2.New(db)
		MustVerifySchema(model)
		svcCtx.ModelV2 = model
	}

	return svcCtx
}

func ConnectToDb() (*sql.DB, error) {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable",
		"localhost", 5432, "postgres", "mysecretpassword", "hellokv")

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

type SchemaGetter interface {
	GetLatestSchema(ctx context.Context) (sql.NullString, error)
	GetSupportedSchemaVersion() string
}

func MustVerifySchema(model SchemaGetter) {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	s, err := model.GetLatestSchema(ctx)
	logx.Must(err)
	if !s.Valid {
		logx.Errorf("version is null")
		os.Exit(1)
	}

	dbVersion, err := semver.NewVersion(s.String)
	if err != nil {
		fmt.Printf("Error parsing version: %s", err)
		return
	}

	supportedVersion, err := semver.NewVersion(model.GetSupportedSchemaVersion())
	if err != nil {
		fmt.Printf("Error parsing version: %s", err)
		return
	}

	if dbVersion.Major() > supportedVersion.Major() {
		logx.Errorf("schema version is too new, service version %s, db version %s", supportedVersion.Original(), dbVersion.Original())
		os.Exit(1)
	}
}
