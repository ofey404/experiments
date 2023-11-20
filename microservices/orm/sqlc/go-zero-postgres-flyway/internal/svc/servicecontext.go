package svc

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/config"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/model/modelv1"
	"github.com/zeromicro/go-zero/core/logx"
)

type ServiceContext struct {
	Config config.Config
	Model  *modelv1.Queries
}

func NewServiceContext(c config.Config) *ServiceContext {
	db, err := ConnectToDb()
	logx.Must(err)

	return &ServiceContext{
		Config: c,
		Model:  modelv1.New(db),
	}
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
