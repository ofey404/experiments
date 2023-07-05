package main

import (
	"context"
	"fmt"
	"time"

	"github.com/ofey404/experiments/cloud/k8s/dynamic_client/shared"
	"github.com/ofey404/experiments/cloud/k8s/utils"

	"github.com/zeromicro/go-zero/core/logx"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/dynamic"
)

func main() {
	config := utils.MustGetLocalConfig()

	client, err := dynamic.NewForConfig(config)
	logx.Must(err)

	resource := client.Resource(shared.TensorboardGVR)

	data, err := resource.Namespace("kubeflow-user-example-com").Get(context.TODO(), "tos-tensorboard-230630", metav1.GetOptions{})
	//data, err := resource.Namespace("kubeflow-user-example-com").Get(context.TODO(), "tos-tensorboard-230630", metav1.GetOptions{})
	logx.Must(err)

	json, err := data.MarshalJSON()
	logx.Must(err)

	fmt.Printf("%s\n", string(json))

	data2, err := resource.Namespace(metav1.NamespaceAll).List(context.TODO(), metav1.ListOptions{})
	logx.Must(err)

	json, err = data2.MarshalJSON()
	logx.Must(err)

	fmt.Printf("%s\n", string(json))

	createTime := data.GetCreationTimestamp()
	namespace := data.GetNamespace()

	fmt.Printf("createTime %s\n", createTime.String())
	fmt.Printf("namespace %s\n", namespace)

	if time.Now().After(createTime.Add(time.Duration(time.Hour))) {
		fmt.Printf("delete %s\n", data.GetName())
	}

}
