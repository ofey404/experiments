package main

import (
	"flag"
	"fmt"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/server"
	"github.com/zeromicro/go-zero/core/service"
	"github.com/zeromicro/go-zero/zrpc"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/config"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/handler"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"
)

var configFile = flag.String("f", "etc/hellokv-api.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)

	svcCtx := svc.NewServiceContext(c)

	if c.Api != nil {
		startApiServer(c, svcCtx)
	} else if c.Rpc != nil {
		startRpcServer(c, svcCtx)
	}
}

func startApiServer(c config.Config, svcCtx *svc.ServiceContext) {
	server := rest.MustNewServer(*c.Api)
	defer server.Stop()

	handler.RegisterHandlers(server, svcCtx)

	fmt.Printf("Starting server at %s:%d...\n", c.Api.Host, c.Api.Port)
	server.Start()
}

func startRpcServer(c config.Config, svcCtx *svc.ServiceContext) {
	s := zrpc.MustNewServer(*c.Rpc, func(grpcServer *grpc.Server) {
		hellokv.RegisterHellokvServer(grpcServer, server.NewHellokvServer(svcCtx))

		if c.Rpc.Mode == service.DevMode || c.Rpc.Mode == service.TestMode {
			reflection.Register(grpcServer)
		}
	})

	defer s.Stop()

	fmt.Printf("Starting rpc server at %s...\n", c.Rpc.ListenOn)
	s.Start()
}
