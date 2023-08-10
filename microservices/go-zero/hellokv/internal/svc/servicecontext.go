package svc

import (
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/config"
)

type ServiceContext struct {
	Config config.Config
	Kv     map[string]string
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		Kv:     make(map[string]string),
	}
}
