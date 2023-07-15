package main

import (
	"flag"
	"fmt"

	"github.com/ofey404/experiments/microservices/auth0/go-zero/backend/internal/config"
	"github.com/ofey404/experiments/microservices/auth0/go-zero/backend/internal/handler"
	"github.com/ofey404/experiments/microservices/auth0/go-zero/backend/internal/svc"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"
)

var configFile = flag.String("f", "etc/kv.yaml", "the config file")

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
