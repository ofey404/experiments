package config

import (
	"github.com/zeromicro/go-zero/rest"
	"github.com/zeromicro/go-zero/zrpc"
)

type Config struct {
	Api *rest.RestConf      `json:",optional"`
	Rpc *zrpc.RpcServerConf `json:",optional"`
}
