package main

import (
	"context"
	"flag"
	"fmt"
	auth "github.com/envoyproxy/go-control-plane/envoy/service/auth/v3"
	"google.golang.org/grpc/reflection"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/zrpc"
	"google.golang.org/grpc"
)

type AuthorizationServer struct{}

func (a *AuthorizationServer) Check(ctx context.Context, req *auth.CheckRequest) (*auth.CheckResponse, error) {
	return nil, nil
}

var confPath = flag.String("f", "config.yaml", "the config file")

// https://github.com/salrashid123/envoy_external_authz/blob/master/authz_server/grpc_server.go
func main() {
	flag.Parse()
	c := &Config{}
	conf.MustLoad(*confPath, c, conf.UseEnv())

	s := zrpc.MustNewServer(
		c.RpcServerConf,
		func(s *grpc.Server) {
			auth.RegisterAuthorizationServer(s, &AuthorizationServer{})

			// enable reflection
			reflection.Register(s)
		},
	)

	fmt.Printf("Starting rpc server at %s, mode %s...\n", c.ListenOn, c.Mode)
	s.Start()
}
