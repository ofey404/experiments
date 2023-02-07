package main

import (
	"context"
	"flag"
	"fmt"

	v1 "github.com/kubeflow/training-operator/pkg/apis/kubeflow.org/v1"
	v12 "k8s.io/api/core/v1"

	"os"
	"path/filepath"

	commonv1 "github.com/kubeflow/common/pkg/apis/common/v1"

	clientv1 "github.com/kubeflow/training-operator/pkg/client/clientset/versioned"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/tools/clientcmd"
	"k8s.io/client-go/util/homedir"
)

func _must(err error) {
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
}

func _int32Pointer(i int) *int32 {
	i32Value := int32(i)
	return &i32Value
}

const (
	list = iota
	create
)

var feature = create

func main() {
	kfcli := createClient()

	switch feature {
	case list:
		listJobs(kfcli)
	case create:
		createJob(kfcli, "pytorch-simple-affinity-by-client")
	}
}

func createClient() *clientv1.Clientset {
	var kubeconfig *string
	if home := homedir.HomeDir(); home != "" {
		kubeconfig = flag.String("kubeconfig", filepath.Join(home, ".kube", "config"), "(optional) absolute path to the kubeconfig file")
	} else {
		kubeconfig = flag.String("kubeconfig", "", "absolute path to the kubeconfig file")
	}
	flag.Parse()

	// use the current context in kubeconfig
	config, err := clientcmd.BuildConfigFromFlags("", *kubeconfig)
	_must(err)

	kfcli, err := clientv1.NewForConfig(config)
	_must(err)
	return kfcli
}

func createJob(kfcli *clientv1.Clientset, name string) {
	job, err := kfcli.KubeflowV1().PyTorchJobs("kubeflow").Create(
		context.TODO(),
		&v1.PyTorchJob{
			TypeMeta: metav1.TypeMeta{
				Kind:       "PyTorchJob",
				APIVersion: "kubeflow.org/v1",
			},
			ObjectMeta: metav1.ObjectMeta{
				Name:      name,
				Namespace: "kubeflow",
			},
			Spec: v1.PyTorchJobSpec{
				PyTorchReplicaSpecs: map[commonv1.ReplicaType]*commonv1.ReplicaSpec{
					"Master": &commonv1.ReplicaSpec{
						Replicas: _int32Pointer(1),
						Template: v12.PodTemplateSpec{
							Spec: v12.PodSpec{
								Containers: []v12.Container{
									{
										Name:            "pytorch",
										Image:           "docker.io/kubeflowkatib/pytorch-mnist:v1beta1-45c5727",
										ImagePullPolicy: v12.PullAlways,
										Command: []string{
											"python3",
											"/opt/pytorch-mnist/mnist.py",
											"--epochs=1",
										},
									},
								},
							},
						},
						RestartPolicy: commonv1.RestartPolicyOnFailure,
					},
					"Worker": &commonv1.ReplicaSpec{
						Replicas: _int32Pointer(2),
						Template: v12.PodTemplateSpec{
							Spec: v12.PodSpec{
								Containers: []v12.Container{
									{
										Name:            "pytorch",
										Image:           "docker.io/kubeflowkatib/pytorch-mnist:v1beta1-45c5727",
										ImagePullPolicy: v12.PullAlways,
										Command: []string{
											"python3",
											"/opt/pytorch-mnist/mnist.py",
											"--epochs=1",
										},
									},
								},
							},
						},
						RestartPolicy: commonv1.RestartPolicyOnFailure,
					},
				},
			},
		},
		metav1.CreateOptions{},
	)
	_must(err)
	fmt.Println(job)
}

func listJobs(kfcli *clientv1.Clientset) {
	jobList, err := kfcli.KubeflowV1().PyTorchJobs("kubeflow").List(context.TODO(), metav1.ListOptions{})
	_must(err)
	fmt.Println(jobList)
}
