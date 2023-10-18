package main

import (
	"context"
	"fmt"

	"github.com/zeromicro/go-zero/core/logx"
	corev1 "k8s.io/api/core/v1"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"
)

func main() {
	kubeconfig := ctrl.GetConfigOrDie()
	c, err := client.New(kubeconfig, client.Options{})
	logx.Must(err)

	nodeList := &corev1.NodeList{}

	err = c.List(context.TODO(), nodeList)
	logx.Must(err)

	// Print node details
	for _, node := range nodeList.Items {
		fmt.Printf("Node name: %s\n", node.Name)
		for label, value := range node.Labels {
			fmt.Printf("  Label %s = %s\n", label, value)
		}
	}
}
