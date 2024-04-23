package main

import (
	"encoding/json"
	"fmt"

	"github.com/zeromicro/go-zero/core/conf"
	"github.com/zeromicro/go-zero/core/logx"
)

type Config struct {
	StringArg        string
	DefaultStringArg string   `json:",default=localhost"`
	ArrayDefaultArg  []string `json:",default=[a,b]"`
}

func main() {
	var c Config

	conf.MustLoad("./config.yaml", &c, conf.UseEnv())
	b, err := json.MarshalIndent(c, "", "  ")
	logx.Must(err)
	fmt.Printf(`## Loaded config:
%s
`, string(b))
}
