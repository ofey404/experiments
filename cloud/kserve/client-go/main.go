// Copyright Istio Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This example is adapted from:
// https://github.com/aspenmesh/istio-client-go/blob/4de6e89009c427dbc602b0c6bbdc8840ef1905e6/cmd/example-client/client.go

package main

import (
	"context"
	"fmt"
	"log"
	"os"
	"strings"
	"time"

	v1 "istio.io/api/security/v1"
	"istio.io/api/type/v1beta1"
	securityv1 "istio.io/client-go/pkg/apis/security/v1"

	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/tools/clientcmd"

	versionedclient "istio.io/client-go/pkg/clientset/versioned"
)

func MustNewIstioClientSet() *versionedclient.Clientset {
	kubeconfig := fmt.Sprintf("%s/.kube/config", os.Getenv("HOME"))

	restConfig, err := clientcmd.BuildConfigFromFlags("", kubeconfig)
	if err != nil {
		log.Fatalf("Failed to create k8s rest client: %s", err)
	}

	ic, err := versionedclient.NewForConfig(restConfig)
	if err != nil {
		log.Fatalf("Failed to create istio client: %s", err)
	}
	return ic
}

func TestApiUsage(ic *versionedclient.Clientset) {
	const namespace = "default"

	// Test VirtualServices
	vsList, err := ic.NetworkingV1alpha3().VirtualServices(namespace).List(context.TODO(), metav1.ListOptions{})
	if err != nil {
		log.Fatalf("Failed to get VirtualService in %s namespace: %s", namespace, err)
	}

	for i := range vsList.Items {
		vs := vsList.Items[i]
		log.Printf("Index: %d VirtualService Hosts: %+v\n", i, vs.Spec.GetHosts())
	}

	// Test DestinationRules
	drList, err := ic.NetworkingV1alpha3().DestinationRules(namespace).List(context.TODO(), metav1.ListOptions{})
	if err != nil {
		log.Fatalf("Failed to get DestinationRule in %s namespace: %s", namespace, err)
	}

	for i := range drList.Items {
		dr := drList.Items[i]
		log.Printf("Index: %d DestinationRule Host: %+v\n", i, dr.Spec.GetHost())
	}

	// Test Gateway
	gwList, err := ic.NetworkingV1alpha3().Gateways(namespace).List(context.TODO(), metav1.ListOptions{})
	if err != nil {
		log.Fatalf("Failed to get Gateway in %s namespace: %s", namespace, err)
	}

	for i := range gwList.Items {
		gw := gwList.Items[i]
		for _, s := range gw.Spec.GetServers() {
			log.Printf("Index: %d Gateway servers: %+v\n", i, s)
		}
	}

	// Test ServiceEntry
	seList, err := ic.NetworkingV1alpha3().ServiceEntries(namespace).List(context.TODO(), metav1.ListOptions{})
	if err != nil {
		log.Fatalf("Failed to get ServiceEntry in %s namespace: %s", namespace, err)
	}

	for i := range seList.Items {
		se := seList.Items[i]
		for _, h := range se.Spec.GetHosts() {
			log.Printf("Index: %d ServiceEntry hosts: %+v\n", i, h)
		}
	}
}

const jwks = `{
  "keys": [
    {
      "kty": "RSA",
      "n": "mmO0OvOPQ53HRxV4eHOkTTxLVfk6zcq8KAD86gbnydYBNO_Si4Q1twyvefd58-BaO4N4NCEA97QrYm57ThKCe8agLGwWPHhxgbu_SAuYQehXxkf4sWy7Q17kGFG5k5AfQGZBqTY-YaawQqLlF6ILVbWab_AoEF4yB7pI3AnNnXs",
      "e": "AQAB"
    }
  ]
}`

func main() {
	ic := MustNewIstioClientSet()
	const namespace = "istio-system"

	if false {
		TestApiUsage(ic)
	}

	MustCreateRequestAuthenticationSync(ic, namespace)
	MustCreateAuthorizationPolicySync(ic, namespace)

	if false {
		MustDeleteRequestAuthentication(ic, namespace)
		MustDeleteAuthorizationPolicy(ic, namespace)
	}
}

func MustCreateAuthorizationPolicySync(ic *versionedclient.Clientset, namespace string) {
	authorizationPolicyApi := ic.SecurityV1().AuthorizationPolicies(namespace)
	const name = "first-inference-service"
	_, err := authorizationPolicyApi.Create(
		context.TODO(),
		&securityv1.AuthorizationPolicy{
			ObjectMeta: metav1.ObjectMeta{
				Name:      name,
				Namespace: namespace,
			},
			Spec: v1.AuthorizationPolicy{
				Selector: &v1beta1.WorkloadSelector{
					MatchLabels: map[string]string{
						"serving.kserve.io/inferenceservice": "sklearn-iris",
					},
				},
				Action: v1.AuthorizationPolicy_ALLOW,
				Rules: []*v1.Rule{
					{
						From: []*v1.Rule_From{
							{
								Source: &v1.Source{
									RequestPrincipals: []string{
										"ofey404@test.com/ofey404",
									},
								},
							},
						},
					},
				},
			},
		},
		metav1.CreateOptions{},
	)
	if err != nil {
		log.Fatalf("Failed to create AuthorizationPolicy in %s namespace: %s", namespace, err)
	}

	for {
		_, err = authorizationPolicyApi.Get(context.TODO(), name, metav1.GetOptions{})
		if err != nil {
			if strings.Contains(err.Error(), "not found") {
				log.Printf("AuthorizationPolicy %s not found, retrying...", name)
				time.Sleep(1 * time.Second)
				continue
			}
			log.Fatalf("Failed to get AuthorizationPolicy in %s namespace: %s", namespace, err)
		}

		break
	}

	log.Printf("AuthorizationPolicy %s created", name)
}

func MustDeleteAuthorizationPolicy(ic *versionedclient.Clientset, namespace string) {
	authorizationPolicyApi := ic.SecurityV1().AuthorizationPolicies(namespace)
	const name = "first-inference-service"
	err := authorizationPolicyApi.Delete(
		context.TODO(),
		name,
		metav1.DeleteOptions{},
	)
	if err != nil {
		log.Fatalf("Failed to delete AuthorizationPolicy in %s namespace: %s", namespace, err)
	}

	log.Printf("AuthorizationPolicy %s deleted", name)
}

func MustCreateRequestAuthenticationSync(ic *versionedclient.Clientset, namespace string) {
	requestAuthenticationApi := ic.SecurityV1().RequestAuthentications(namespace)
	const name = "inference-service"
	_, err := requestAuthenticationApi.Create(
		context.TODO(),
		&securityv1.RequestAuthentication{
			ObjectMeta: metav1.ObjectMeta{
				Name:      name,
				Namespace: namespace,
			},
			Spec: v1.RequestAuthentication{
				Selector: &v1beta1.WorkloadSelector{
					MatchLabels: map[string]string{
						"serving.kserve.io/inferenceservice": "sklearn-iris",
					},
				},
				JwtRules: []*v1.JWTRule{
					{
						Issuer: "ofey404@test.com",
						Jwks:   jwks,
					},
				},
			},
		},
		metav1.CreateOptions{},
	)
	if err != nil {
		log.Fatalf("Failed to create RequestAuthentication in %s namespace: %s", namespace, err)
	}

	for {
		_, err = requestAuthenticationApi.Get(context.TODO(), name, metav1.GetOptions{})
		if err != nil {
			if strings.Contains(err.Error(), "not found") {
				log.Printf("RequestAuthentication %s not found, retrying...", name)
				time.Sleep(1 * time.Second)
				continue
			}
			log.Fatalf("Failed to get RequestAuthentication in %s namespace: %s", namespace, err)
		}

		break
	}

	log.Printf("RequestAuthentication %s created", name)
}

func MustDeleteRequestAuthentication(ic *versionedclient.Clientset, namespace string) {
	requestAuthenticationApi := ic.SecurityV1().RequestAuthentications(namespace)
	const name = "inference-service"
	err := requestAuthenticationApi.Delete(
		context.TODO(),
		name,
		metav1.DeleteOptions{},
	)
	if err != nil {
		log.Fatalf("Failed to delete RequestAuthentication in %s namespace: %s", namespace, err)
	}

	log.Printf("RequestAuthentication %s deleted", name)
}
