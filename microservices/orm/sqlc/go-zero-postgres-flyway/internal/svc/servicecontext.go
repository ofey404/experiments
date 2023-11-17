package svc

import (
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/config"
)

type ServiceContext struct {
	Config config.Config
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
	}
}
