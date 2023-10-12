package main

import (
	"encoding/json"
	"fmt"
	"testing"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"

	notebookApi "github.com/kubeflow/kubeflow/components/notebook-controller/api/v1"
	"github.com/stretchr/testify/assert"
	v1 "k8s.io/api/core/v1"
)

// See what string json.Marshal would produce.
func TestSerializatiton(t *testing.T) {
	ast := assert.New(t)
	var resource = &notebookApi.Notebook{
		ObjectMeta: metav1.ObjectMeta{
			Name: "name",
			Labels: map[string]string{
				"app":  "notebook",
				"name": "label name",
			},
		},
		Spec: notebookApi.NotebookSpec{
			Template: notebookApi.NotebookTemplateSpec{
				Spec: v1.PodSpec{
					Containers: []v1.Container{
						{
							Name:  "notebook",
							Image: "kubeflownotebookswg/jupyter:v1.6.0-rc.0",
						},
					},
				},
			},
		},
	}

	b, err := json.Marshal(resource)
	ast.Nil(err)
	fmt.Printf("resource = %s\n", string(b))
}
