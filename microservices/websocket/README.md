# websocket

Run: 

```bash
./run.sh 
# ## wait for server to start
# listening on http://127.0.0.1:5000
# ## now you can type like echo command
# Connected (press CTRL+C to quit)
# > echo 
# < echo
# > test
# < test
# > kjlfads
# < kjlfads
# > failed to echo with 127.0.0.1:50214: failed to get reader: received close frame: status = StatusNoStatusRcvd and reason = ""
# Terminated
```

## Reference

We use https://pkg.go.dev/nhooyr.io/websocket

The example go code comes from: https://github.com/nhooyr/websocket/tree/master/examples/echo

## How to play with websocket

[Use wscat to connect to a WebSocket API and send messages to it](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-how-to-call-websocket-api-wscat.html)

Or use [hashrocket/ws](https://github.com/hashrocket/ws), but it doesn't support sub-protocol.

