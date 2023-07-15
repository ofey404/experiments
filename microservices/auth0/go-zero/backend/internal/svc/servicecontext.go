package svc

import (
	"github.com/ofey404/experiments/microservices/auth0/go-zero/backend/internal/config"
)

type ServiceContext struct {
	Config config.Config
	Map    map[string]string
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		Map:    make(map[string]string),
	}
}
