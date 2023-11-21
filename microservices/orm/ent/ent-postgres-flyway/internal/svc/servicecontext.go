package svc

import (
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/config"
)

type ServiceContext struct {
	Config config.Config
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
	}
}
