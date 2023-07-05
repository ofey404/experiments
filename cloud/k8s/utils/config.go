package utils

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/zeromicro/go-zero/core/logx"
	"k8s.io/client-go/rest"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
)

func MustGetLocalConfig() *rest.Config {
	home := homedir.HomeDir()
	if home == "" {
		fmt.Printf("home is empty\n")
		os.Exit(1)
	}
	configPath := filepath.Join(home, ".kube", "config")
	if !exist(configPath) {
		fmt.Printf("config doesn't exist\n")
		os.Exit(1)
	}

	config, err := clientcmd.BuildConfigFromFlags("", configPath)
	logx.Must(err)
	return config
}

func exist(path string) bool {
	stat, err := os.Stat(path)
	return err == nil && !stat.IsDir()
}
