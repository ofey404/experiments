# stacktrace

In this repo, I try to master the stacktrace and logging feature based on go-zero.

## simple

It shows how `errors.Wrap` and `logx` package works.

## full-service

This example is to solve multiple problems inter tangled together (Chinese):

1. 访问和 error 日志是两条。
2. 日志需要集成 trace ID
3. 日志需要打 KV，stack、traceID、error content 希望能分开

The log-tracing problem is an architecture level problem,
so I make this POC to show how to solve it.

## 1. Can we dump custom field to HTTP Log?

The answer is no.

It's burned into the builtin middleware, unless we want to recreate the whole logging middleware.

```go
package rest
// rest/engine.go
func (ng *engine) buildChainWithNativeMiddlewares() {}
```

## 2. Trace ID

(1), place internal state like userid in the same log, is a method rather than a goal.

What we want to achieve is to trace all log generated by the same request, and filter out all the noise.

The trace ID seems to be fit.

```go
func (m *TraceIDMiddleware) Handle(next http.HandlerFunc) http.HandlerFunc {
    return func (w http.ResponseWriter, r *http.Request) {
        trace.TraceIDFromContext(r.Context())
        w.Header().Set("x-trace-id", trace.TraceIDFromContext(r.Context()))
        next(w, r)
    }
}
```

```bash
./launch.sh
./try.sh

# service log:
#
# {"@timestamp":"2023-07-26T11:31:26.283+08:00","caller":"handler/loghandler.go:196","content":"[HTTP] 200 
# - POST /api/get - 127.0.0.1:59910 - curl/7.81.0","duration":"0.2ms","level":"info","span":"866fcc01f46752cf",
# "trace":"86ed0a738dad0663232bf306044c23ed"}

# curl output:
# ...
# < X-Trace-Id: 86ed0a738dad0663232bf306044c23ed
```

Also, we can also use istio's trace ID, but it's beyond our scope.

[Distributed Tracing FAQ | Istio](https://istio.io/latest/about/faq/distributed-tracing/)