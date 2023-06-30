# kubeflow distribution

[kubeflow/manifests](https://github.com/kubeflow/manifests)

Install with a single-line command:

```bash
while ! kustomize build example | awk '!/well-defined/' | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done
```