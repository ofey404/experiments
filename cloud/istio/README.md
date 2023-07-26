# istio

This is my playground of [istio](https://istio.io/latest/)

## v1.13

VolcEngine also provide managed istio 1.13:
[服务网格 | 火山引擎](https://www.volcengine.com/docs/6496/73571)

The [1.13 doc](https://istio.io/v1.13/) could be the single source of truth.

feature it has:

1. [Using an External HTTPS Proxy](https://istio.io/v1.13/docs/tasks/traffic-management/egress/http-proxy/)

feature v1.13 doesn't have:

1. [Copy JWT Claims to HTTP Headers | since v1.17](https://istio.io/v1.18/docs/tasks/security/authentication/claim-to-header/)
   - We can work around it with a [EnvoyFilter](https://istio.io/v1.13/docs/reference/config/networking/envoy-filter/)
     after JWT auth.
   - [Setting request headers with values from a JWT](https://discuss.istio.io/t/setting-request-headers-with-values-from-a-jwt/5903)
