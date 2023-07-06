package main

import (
	"context"

	"github.com/ofey404/experiments/cloud/k8s/dynamic_client/shared"
	"github.com/zeromicro/go-zero/core/logx"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/apis/meta/v1/unstructured"
)

func main() {
	api := shared.TensorboardApi()
	_, err := api.Namespace("default").Create(
		context.TODO(),
		&unstructured.Unstructured{
			Object: map[string]any{
				"apiVersion": "tensorboard.kubeflow.org/v1alpha1",
				"kind":       "Tensorboard",
				"metadata": map[string]any{
					"name": "created-by-dynamic-client",
				},
				"spec": map[string]any{
					"logspath": "host://tensorboard/log/dir", // hostpath /tensorboard/log/dir
				},
			},
		},
		metav1.CreateOptions{},
	)
	logx.Must(err)
}
