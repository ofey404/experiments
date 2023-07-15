# go-zero

This playground is for the go-zero stack.

```text
┌───────────┐
│  Auth0    │
└───┬───────┘
    │ JWT(User, Permission)
    │
┌───▼───────┐
│  Istio    │
└───┬───────┘
    │ outputPayloadToHeader:
    │ User, Permission
┌───▼───────┐
│  go-zero  │
└───────────┘
```

About the `outputPayloadToHeader` section, see the discussion:
[[Question] Decode JWT and put “sub” into a request header](https://discuss.istio.io/t/question-decode-jwt-and-put-sub-into-a-request-header/1213/19)
