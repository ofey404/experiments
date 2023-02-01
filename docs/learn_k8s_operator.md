# Learn k8s operator

Reference: https://betterprogramming.pub/build-a-kubernetes-operator-in-10-minutes-11eec1492d30

Commands:

```bash
#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

go install sigs.k8s.io/kind@v0.17.0
# kind create cluster

curl -L -o kubebuilder https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH) && chmod +x kubebuilder && mv kubebuilder /usr/local/bin/

# kubebuilder init --domain my.domain --repo my.domain/tutorial
```