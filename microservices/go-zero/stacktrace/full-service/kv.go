package main

import (
	"flag"
	"fmt"

	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/config"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/handler"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/svc"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"
)

var configFile = flag.String("f", "microservices/go-zero/stacktrace/full-service/etc/kv.yaml", "the config file")

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
