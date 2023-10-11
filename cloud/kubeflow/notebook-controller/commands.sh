#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n notebook-controller
docker update --restart=no notebook-controller-control-plane

istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

# create controller
kubectl apply -k kustomization/

kubectl apply -f gateway.yaml
kubectl apply -f notebook-sample.yaml


#####################################################################
# use dynamic client
# See:
# https://hackernoon.com/platforms-on-k8s-with-golang-watch-any-crd-0v2o3z1q
#####################################################################

# https://github.com/kubernetes/client-go/issues/1075
# after all this fixes all issue, but downgrade client-go to 0.24

go get k8s.io/kube-openapi@v0.0.0-20211115234752-e816edb12b65
cd go-client
    go run .
    # notebookApi.NotebookList = &{TypeMeta:{Kind: APIVersion:} ListMeta:{SelfLink: ResourceVersion:18389 Continue: RemainingItemCount:<nil>} Items:[{TypeMeta:{Kind:Notebook APIVersion:kubeflow.org/v1} ObjectMeta:{Name:notebook-sample GenerateName: Namespace:default SelfLink: UID:a06f3989-08ab-4d50-8562-0640129993bf ResourceVersion:13554 Generation:1 CreationTimestamp:2023-10-10 10:26:18 +0800 CST DeletionTimestamp:<nil> DeletionGracePeriodSeconds:<nil> Labels:map[] Annotations:map[kubectl.kubernetes.io/last-applied-configuration:{"apiVersion":"kubeflow.org/v1","kind":"Notebook","metadata":{"annotations":{},"name":"notebook-sample","namespace":"default"},"spec":{"template":{"spec":{"containers":[{"image":"kubeflownotebookswg/jupyter:v1.6.0-rc.0","name":"notebook-sample"}]}}}}] OwnerReferences:[] Finalizers:[] ClusterName: ManagedFields:[{Manager:kubectl-client-side-apply Operation:Update APIVersion:kubeflow.org/v1 Time:2023-10-10 10:26:18 +0800 CST FieldsType:FieldsV1 FieldsV1:{"f:metadata":{"f:annotations":{".":{},"f:kubectl.kubernetes.io/last-applied-configuration":{}}},"f:spec":{".":{},"f:template":{".":{},"f:spec":{}}}} Subresource:} {Manager:manager Operation:Update APIVersion:kubeflow.org/v1beta1 Time:2023-10-11 17:04:26 +0800 CST FieldsType:FieldsV1 FieldsV1:{"f:status":{".":{},"f:conditions":{},"f:containerState":{".":{},"f:running":{".":{},"f:startedAt":{}}},"f:readyReplicas":{}}} Subresource:status}]} Spec:{Template:{Spec:{Volumes:[] InitContainers:[] Containers:[{Name:notebook-sample Image:kubeflownotebookswg/jupyter:v1.6.0-rc.0 Command:[] Args:[] WorkingDir: Ports:[] EnvFrom:[] Env:[] Resources:{Limits:map[] Requests:map[]} VolumeMounts:[] VolumeDevices:[] LivenessProbe:nil ReadinessProbe:nil StartupProbe:nil Lifecycle:nil TerminationMessagePath: TerminationMessagePolicy: ImagePullPolicy: SecurityContext:nil Stdin:false StdinOnce:false TTY:false}] EphemeralContainers:[] RestartPolicy: TerminationGracePeriodSeconds:<nil> ActiveDeadlineSeconds:<nil> DNSPolicy: NodeSelector:map[] ServiceAccountName: DeprecatedServiceAccount: AutomountServiceAccountToken:<nil> NodeName: HostNetwork:false HostPID:false HostIPC:false ShareProcessNamespace:<nil> SecurityContext:nil ImagePullSecrets:[] Hostname: Subdomain: Affinity:nil SchedulerName: Tolerations:[] HostAliases:[] PriorityClassName: Priority:<nil> DNSConfig:nil ReadinessGates:[] RuntimeClassName:<nil> EnableServiceLinks:<nil> PreemptionPolicy:<nil> Overhead:map[] TopologySpreadConstraints:[] SetHostnameAsFQDN:<nil> OS:nil}}} Status:{Conditions:[{Type:Initialized Status:True LastProbeTime:2023-10-11 17:04:26 +0800 CST LastTransitionTime:2023-10-10 10:26:18 +0800 CST Reason: Message:} {Type:Ready Status:True LastProbeTime:2023-10-11 17:04:26 +0800 CST LastTransitionTime:2023-10-11 17:03:58 +0800 CST Reason: Message:} {Type:ContainersReady Status:True LastProbeTime:2023-10-11 17:04:26 +0800 CST LastTransitionTime:2023-10-11 17:03:58 +0800 CST Reason: Message:} {Type:PodScheduled Status:True LastProbeTime:2023-10-11 17:04:26 +0800 CST LastTransitionTime:2023-10-10 10:26:18 +0800 CST Reason: Message:}] ReadyReplicas:1 ContainerState:{Waiting:nil Running:&ContainerStateRunning{StartedAt:2023-10-11 17:03:57 +0800 CST,} Terminated:nil}}}]}
cd -