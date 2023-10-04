# from-kubeflow

This is a working subset of kubeflow's SSO components.

Here is a sequence diagram for the authentication flow:
https://github.com/arrikto/oidc-authservice#sequence-diagram-for-an-authentication-flow

## References

[Kubeflow: Authentication with Istio + Dex](https://www.arrikto.com/blog/kubeflow/news/kubeflow-authentication-with-istio-dex/)

[Istio Usage in Kubeflow](https://www.kubeflow.org/docs/components/multi-tenancy/istio/)

A video explaining what the kubeflow do:
[Enabling Multi-user Machine Learning Workflows for Kubeflow Pipelines - Yannis Zarkadas & Yuan Gong](https://www.youtube.com/watch?v=U8yWOKOhzes)

This link shows how to troubleshoot the istio RBAC policy:
[Ensure proxies enforce policies correctly](https://istio.io/latest/docs/ops/common-problems/security-issues/#ensure-proxies-enforce-policies-correctly)
