package main

import (
	"context"
	"fmt"
	"github.com/ofey404/experiments/utils"
	"github.com/zeromicro/go-zero/core/logx"
	batchv1 "k8s.io/api/batch/v1"
	"k8s.io/apimachinery/pkg/runtime"
	ctrl "sigs.k8s.io/controller-runtime"

	toolscache "k8s.io/client-go/tools/cache"

	"sigs.k8s.io/controller-runtime/pkg/cache"
)

// This is a watcher for job resources.
func main() {
	ctx := context.Background()
	scheme := runtime.NewScheme()

	err := batchv1.AddToScheme(scheme)
	logx.Must(err)

	kubeconfig := ctrl.GetConfigOrDie()

	c, err := cache.New(kubeconfig, cache.Options{Scheme: scheme})
	logx.Must(err)

	informer, err := c.GetInformer(ctx,
		&batchv1.Job{},
	)
	logx.Must(err)

	_, err = informer.AddEventHandler(toolscache.ResourceEventHandlerFuncs{
		AddFunc: func(obj interface{}) {
			defer panicRecover()

			job := obj.(*batchv1.Job)
			fmt.Printf("Job %s created\n", job.Name)
		},
		UpdateFunc: func(oldObj, newObj interface{}) {
			defer panicRecover()
			oldJob, newJob := oldObj.(*batchv1.Job), newObj.(*batchv1.Job)

			fmt.Printf(`Job %s updated,
## From
%s
## To
%s
`, newJob.Name, utils.SprintAsJson(oldJob.Status), utils.SprintAsJson(newJob.Status))
		},
		DeleteFunc: func(obj interface{}) {
			defer panicRecover()

			job := obj.(*batchv1.Job)
			fmt.Printf("Job %s deleted\n", job.Name)
		},
	})
	logx.Must(err)

	fmt.Printf("Starting the watcher\n")
	fmt.Printf("kubeconfig Host: %s\n", kubeconfig.Host)
	err = c.Start(ctx)
	logx.Must(err)
}

func panicRecover() {
	if r := recover(); r != nil {
		logx.Error("panic recovered from ", r)
	}
}
