package svc

import (
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/ent"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/config"
	"github.com/zeromicro/go-zero/core/logx"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/lib/pq"
)

type ServiceContext struct {
	Config config.Config
	Client *ent.Client
}

func NewServiceContext(c config.Config) *ServiceContext {
	client, err := ent.Open(c.Db.Driver, c.Db.Source)
	logx.Must(err)

	return &ServiceContext{
		Config: c,
		Client: client,
	}
}
