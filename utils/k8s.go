package utils

import (
	"os"
	"path/filepath"

	"github.com/zeromicro/go-zero/core/logx"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
)

func MustLoadKubeconfig() *rest.Config {
	if home := homedir.HomeDir(); home != "" {
		configPath := filepath.Join(home, ".kube", "config")
		if exist(configPath) {
			c, err := clientcmd.BuildConfigFromFlags("", configPath)
			logx.Must(err)
			return c
		}
	}

	c, err := rest.InClusterConfig()
	logx.Must(err)
	return c
}

func exist(path string) bool {
	stat, err := os.Stat(path)
	return err == nil && !stat.IsDir()
}
