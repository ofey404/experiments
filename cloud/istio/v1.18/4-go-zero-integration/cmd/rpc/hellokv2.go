package main

import (
	"flag"
	"fmt"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/internal/config"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/internal/server"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/internal/svc"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/core/service"
	"github.com/zeromicro/go-zero/zrpc"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

var configFile = flag.String("f", "etc/hellokv2.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)
	ctx := svc.NewServiceContext(c)

	s := zrpc.MustNewServer(c.RpcServerConf, func(grpcServer *grpc.Server) {
		hellokv.RegisterHellokvServer(grpcServer, server.NewHellokvServer(ctx))

		if c.Mode == service.DevMode || c.Mode == service.TestMode {
			reflection.Register(grpcServer)
		}
	})
	defer s.Stop()

	fmt.Printf("Starting rpc server at %s...\n", c.ListenOn)
	s.Start()
}
