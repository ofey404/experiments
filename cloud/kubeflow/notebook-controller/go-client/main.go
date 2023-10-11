package main

import (
	"context"
	"fmt"
	"log"

	notebookApi "github.com/kubeflow/kubeflow/components/notebook-controller/api/v1"
	"k8s.io/apimachinery/pkg/runtime"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"
)

func NewNotebookClient() client.Client {
	scheme := runtime.NewScheme()
	notebookApi.AddToScheme(scheme)
	kubeconfig := ctrl.GetConfigOrDie()

	notebookClient, err := client.New(kubeconfig, client.Options{Scheme: scheme})
	if err != nil {
		log.Fatal(err)
		return nil
	}

	return notebookClient
}

func main() {
	// list
	c := NewNotebookClient()

	list := &notebookApi.NotebookList{}
	err := c.List(context.TODO(), list, &client.ListOptions{})
	if err != nil {
		log.Fatal(err)
		return
	}
	fmt.Printf("notebookApi.NotebookList = %+v\n", list)
}
