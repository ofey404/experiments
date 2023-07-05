package main

import (
	"context"
	"flag"
	"fmt"
	"os"

	"github.com/ofey404/experiments/cloud/k8s/dynamic_client/shared"
	"github.com/ofey404/experiments/cloud/k8s/utils"
	"github.com/zeromicro/go-zero/core/logx"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/apis/meta/v1/unstructured"
	"k8s.io/apimachinery/pkg/util/yaml"
	"k8s.io/client-go/dynamic"
)

var yamlFile = flag.String("f", "./tensorboard.yaml", "the yaml file")

func tensorboard(filePath string) *unstructured.Unstructured {
	content, err := os.ReadFile(filePath)
	logx.Must(err)

	fmt.Printf("content: %s\n", string(content))
	obj := &unstructured.Unstructured{}
	logx.Must(
		yaml.Unmarshal(content, &obj.Object),
	)
	fmt.Printf("obj: %v\n", obj.Object)
	return obj
}

func main() {
	flag.Parse()
	config := utils.MustGetLocalConfig()

	client, err := dynamic.NewForConfig(config)
	logx.Must(err)

	resource := client.Resource(shared.TensorboardGVR)

	obj := tensorboard(*yamlFile)
	result, err := resource.Apply(context.TODO(), "dynamical-created", obj, metav1.ApplyOptions{})
	logx.Must(err)

	resultJson, err := result.MarshalJSON()
	logx.Must(err)

	fmt.Printf("result: %s\n", resultJson)
}
