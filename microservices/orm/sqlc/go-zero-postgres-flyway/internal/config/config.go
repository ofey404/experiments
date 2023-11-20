package config

import "github.com/zeromicro/go-zero/rest"

const (
	SchemaVersionV1 = "v1"
	SchemaVersionV2 = "v2"
)

type Config struct {
	rest.RestConf
	SchemaVersion string `json:",options=[v1,v2]"`
}
