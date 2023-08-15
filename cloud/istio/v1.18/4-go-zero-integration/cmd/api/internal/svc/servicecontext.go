package svc

import (
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/config"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv2client"
	"github.com/zeromicro/go-zero/zrpc"
)

type ServiceContext struct {
	Config config.Config
	Rpc    hellokv2client.Hellokv2
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config: c,
		Rpc:    hellokv2client.NewHellokv2(zrpc.MustNewClient(c.RpcConf)),
	}
}
