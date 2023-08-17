# 8-production-best-practice

## General

[Best practices for setting up and managing an Istio service mesh.](https://istio.io/latest/docs/ops/best-practices/)
 
And this:

[Setup a production-ready Istio](https://lapee79.github.io/en/article/setup-a-production-ready-istio/)

The article is old, but the concerns are still valid.

- improve performance by using tuned settings.
- enable SDS to secure gateways.
  * Now just enable HTTPS support: [Istio / Secure Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)
- integrate with Prometheus operator, Grafana, Jaeger and Kiali.

## Deployment Best Practices

[Istio / Deployment Best Practices](https://istio.io/latest/docs/ops/best-practices/deployment/)

- Deploy fewer clusters
- Deploy clusters near your users
- Deploy across multiple availability zones

## Traffic Management Best Practices

[Istio / Traffic Management Best Practices](https://istio.io/latest/docs/ops/best-practices/traffic-management/)

Set default routes for services.

There should only be one “catch-all” rule (i.e., a rule without a match field) in the fragments. 

When adding new subsets:

1. Update DestinationRules to add a new subset first, before updating any VirtualServices that use it. Apply the rule using kubectl or any platform-specific tooling.
2. Wait a few seconds for the DestinationRule configuration to propagate to the Envoy sidecars
3. Update the VirtualService to refer to the newly added subsets.

When removing subsets:

1. Update VirtualServices to remove any references to a subset, before removing the subset from a DestinationRule.
2. Wait a few seconds for the VirtualService configuration to propagate to the Envoy sidecars.
3. Update the DestinationRule to remove the unused subsets.

## Security Best Practices

[Istio / Security Best Practices](https://istio.io/latest/docs/ops/best-practices/security/)

[Security Overview | Istio](https://istio.io/latest/docs/concepts/security/)
is recommend before doing this.

[Mutual TLS Migration](https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/)
is recommended.

Authorization:

1. Use default-deny patterns
2. Use ALLOW-with-positive-matching and DENY-with-negative-match patterns

## Image Signing and Validation

[Istio / Image Signing and Validation](https://istio.io/latest/docs/ops/best-practices/image-signing-validation/)

## Observability Best Practices

[Istio / Observability Best Practices](https://istio.io/latest/docs/ops/best-practices/observability/)