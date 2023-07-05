package shared

import "k8s.io/apimachinery/pkg/runtime/schema"

var TensorboardGVR = schema.GroupVersionResource{
	Group:    "tensorboard.kubeflow.org",
	Version:  "v1alpha1",
	Resource: "tensorboards",
}
