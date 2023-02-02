# k8s go client

Start a local k8s deployment with a registry.

```bash
./kind_with_registry.sh
```

Then run `main.go` in the cluster.

```bash
./run.sh
```

## environment

We use `kind`.

Kind don't have a feature like `$(minikube docker-env)`, so we can use this script:
[Create A Cluster And Registry](https://kind.sigs.k8s.io/docs/user/local-registry/)

## RBAC Permission

https://stackoverflow.com/questions/47973570/kubernetes-log-user-systemserviceaccountdefaultdefault-cannot-get-services
