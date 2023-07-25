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
