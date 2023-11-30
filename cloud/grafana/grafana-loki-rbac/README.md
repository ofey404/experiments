# grafana-loki-rbac

There are some solutions built by other engineers: https://github.com/k8spin/prometheus-multi-tenant-proxy

[Cortex: How to Run a Rock Solid Multi-Tenant Prometheus - Friedrich Gonzalez, Adobe & Alan Protasio](https://www.youtube.com/watch?app=desktop&v=Pl5hEoRPLJU)

- The relating project: https://github.com/cortexproject/cortex

## From GPT4

This is a common use case when different teams or users should only have access
to their own metrics. Grafana itself doesn't provide any mechanism to filter
data based on user roles. But with the help of reverse proxy and Prometheus
recording rules, we can achieve this.

1. **Reverse Proxy**: You can set up a reverse proxy in front of Prometheus to
   filter incoming requests based on some user-specific information, such as a
   header. The reverse proxy can rewrite the queries to only return metrics
   about the user's Pod. This method requires a consistent naming convention for
   your metrics and Pods.

2. **Prometheus recording rules**: You can create recording rules in Prometheus
   to pre-calculate frequently needed or computationally expensive expressions
   and save their result as a new set of time series. You can define recording
   rules based on Pod names. Then in Grafana, you can create different
   dashboards for different users and use the pre-calculated recording rules
   metrics.

3. **Prometheus Multi-tenancy**: Prometheus does not directly support
   multi-tenancy. But it can be made quasi multi-tenant, with separate data per
   tenant by running separate Prometheus servers or Alertmanagers per tenant.
   This is not recommended, as it defeats the purpose of Prometheus's shared
   resource pool across all tenants.

4. **Grafana permissions**: Grafana offers built-in roles that provide certain
   levels of permissions. You can set these roles for users to control what they
   can access and do within Grafana. But it doesn't offer data-level permission
   control.

5. **Loki and Grafana with multi-tenancy**: If you are using Loki for logs, it
   has built-in support for multi-tenancy. You can then use this in Grafana to
   show only relevant logs to the users.

Remember to always secure your Prometheus and Grafana instances, as they can
provide a lot of information about your cluster.
