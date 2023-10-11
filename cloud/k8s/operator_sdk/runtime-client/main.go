package runtime_client

import (
	"context"
	"log"

	cachev1alpha1 "github.com/ofey404/experiments/cloud/k8s/operator_sdk/memcached-operator/api/v1alpha1"
	"k8s.io/apimachinery/pkg/runtime"
	ctrl "sigs.k8s.io/controller-runtime"
	"sigs.k8s.io/controller-runtime/pkg/client"
)

var kclient client.Client

// the kubebuilder community recommends the new way: controller-runtime client
//
// https://hackernoon.com/platforms-on-k8s-with-golang-watch-any-crd-0v2o3z1q
// https://github.com/operator-framework/operator-sdk/issues/1975
// https://github.com/kubernetes-sigs/kubebuilder/issues/1152

func init() {
	kclient = GetClient()
}

func GetClient() client.Client {
	scheme := runtime.NewScheme()
	cachev1alpha1.AddToScheme(scheme)
	kubeconfig := ctrl.GetConfigOrDie()
	controllerClient, err := client.New(kubeconfig, client.Options{Scheme: scheme})
	if err != nil {
		log.Fatal(err)
		return nil
	}
	return controllerClient
}

func List(namespace string) (result *cachev1alpha1.MemcachedList, err error) {
	list := &cachev1alpha1.MemcachedList{}
	err = kclient.List(context.TODO(), list, &client.ListOptions{Namespace: namespace})
	return list, err
}

func Create(deployment *cachev1alpha1.Memcached) (sdep *cachev1alpha1.Memcached, err error) {
	err = kclient.Create(context.TODO(), deployment)
	return deployment, err
}
