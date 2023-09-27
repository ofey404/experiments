package svc

import "github.com/ofey404/experiments/microservices/go-zero/shared-proto/greeter2/internal/config"

type ServiceContext struct {
	Config config.Config
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
	}
}
