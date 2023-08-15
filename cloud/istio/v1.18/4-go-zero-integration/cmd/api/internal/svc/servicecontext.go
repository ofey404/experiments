package svc

import (
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/config"
)

type ServiceContext struct {
	Config config.Config
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
	}
}
