package main

import (
	"flag"
	"fmt"
	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/zrpc"
	"google.golang.org/grpc"
)

var confPath = flag.String("f", "ext_authz.yaml", "the config file")

// https://github.com/salrashid123/envoy_external_authz/blob/master/authz_server/grpc_server.go
func main() {
	flag.Parse()
	c := &Config{}
	conf.MustLoad(*confPath, c, conf.UseEnv())

	s := zrpc.MustNewServer(
		c.RpcServerConf,
		func(server *grpc.Server) {
		},
	)

	fmt.Printf("Starting rpc server at %s...\n", c.ListenOn)
	s.Start()
}
