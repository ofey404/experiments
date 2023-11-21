package config

import "github.com/zeromicro/go-zero/rest"

const (
	MySql    = "mysql"
	Postgres = "postgres"
)

type Config struct {
	rest.RestConf
	Db struct {
		Driver string `json:",options=[mysql,postgres]"`
		Source string
	}
}
