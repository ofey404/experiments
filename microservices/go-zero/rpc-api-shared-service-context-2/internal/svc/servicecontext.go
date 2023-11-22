package svc

import (
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/config"
)

type ServiceContext struct {
	Config config.Config
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
	}
}
