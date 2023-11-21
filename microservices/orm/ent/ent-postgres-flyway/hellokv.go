package main

import (
	"flag"
	"fmt"

	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/config"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/handler"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/svc"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/rest"
)

var configFile = flag.String("f", "etc/hellokv-api.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)

	server := rest.MustNewServer(c.RestConf)
	defer server.Stop()

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	fmt.Printf("Using database driver %s, source %s...\n", c.Db.Driver, c.Db.Source)
	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}
