package main

import (
	"context"
	"flag"
	"fmt"
	"os"
	"path/filepath"

	clientv1 "github.com/kubeflow/training-operator/pkg/client/clientset/versioned"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
)

func _must(err error) {
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
}

func main() {
	var kubeconfig *string
	if home := homedir.HomeDir(); home != "" {
		kubeconfig = flag.String("kubeconfig", filepath.Join(home, ".kube", "config"), "(optional) absolute path to the kubeconfig file")
	} else {
		kubeconfig = flag.String("kubeconfig", "", "absolute path to the kubeconfig file")
	}
	flag.Parse()

	// use the current context in kubeconfig
	config, err := clientcmd.BuildConfigFromFlags("", *kubeconfig)
	_must(err)

	kfcli, err := clientv1.NewForConfig(config)
	_must(err)

	jobs, err := kfcli.KubeflowV1().PyTorchJobs("kubeflow").List(context.TODO(), metav1.ListOptions{})
	_must(err)
	fmt.Println(jobs)
}
