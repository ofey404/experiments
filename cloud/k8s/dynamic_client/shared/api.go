package shared

import (
	"github.com/ofey404/experiments/cloud/k8s/utils"
	"github.com/zeromicro/go-zero/core/logx"
	"k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/client-go/dynamic"
)

var tensorboardGVR = schema.GroupVersionResource{
	Group:    "tensorboard.kubeflow.org",
	Version:  "v1alpha1",
	Resource: "tensorboards",
}

func TensorboardApi() dynamic.NamespaceableResourceInterface {
	config := utils.MustGetLocalConfig()

	client, err := dynamic.NewForConfig(config)
	logx.Must(err)

	resource := client.Resource(tensorboardGVR)
	return resource
}
