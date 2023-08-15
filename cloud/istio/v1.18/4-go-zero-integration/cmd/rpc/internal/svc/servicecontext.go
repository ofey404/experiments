package svc

import (
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/internal/config"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/model"
)

type ServiceContext struct {
	Config config.Config
	Model  model.HelloKv2Model
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		Model:  model.NewHelloKv2Model(c.Mongo.Uri, c.Mongo.Db, c.Mongo.Collection),
	}
}
