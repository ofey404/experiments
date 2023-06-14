package main

import (
	"flag"
	"fmt"

	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/config"
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/handler"
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/svc"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"
)

var configFile = flag.String("f", "etc/hellokv-api.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)

	server := rest.MustNewServer(c.RestConf, rest.WithCors("*"))
	defer server.Stop()

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}
