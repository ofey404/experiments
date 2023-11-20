# RPC/API shared context

Given different config files, this service could serve both RPC and API requests.

More to see [./commands.sh](./commands.sh)

File structure shows as below, I've omitted unimportant files.

```plain text
tree -L 2
.
├── hellokv.go               // main
├── etc                      // config files
│   ├── hellokv-api.yaml     // for API
│   └── hellokv.yaml         // for RPC
├── api                      // API definition
│   └── hellokv.api
├── pb                       // gRPC protobuf definition
│   └── hellokv.proto
├── hellokv
│   ├── hellokv.pb.go
│   └── hellokv_grpc.pb.go
├── hellokvclient
│   └── hellokv.go
└── internal                 // shared logic and service context
    ├── config
    │   └── config.go
    ├── handler
    │   ├── api
    │   └── routes.go
    ├── logic                // shared logic, API & RPC packages can import each other
    │   ├── api              // API
    │   │   ├── getlogic.go
    │   │   └── setlogic.go
    │   ├── getlogic.go      // RPC
    │   └── setlogic.go
    ├── server
    │   └── hellokvserver.go
    ├── svc
    │   └── servicecontext.go
    └── types
        └── types.go
```

Example of a shared logic implementation, RPC reuses API logic implementation:

```go
// microservices/go-zero/rpc-api-shared-service-context/internal/logic/getlogic.go
package logic

import (
	"context"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/logic/api"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
)

type GetLogic struct {
	*api.GetLogic
}

func NewGetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetLogic {
	return &GetLogic{
		GetLogic: api.NewGetLogic(ctx, svcCtx),
	}
}

func (l *GetLogic) Get(in *hellokv.GetRequest) (*hellokv.GetResponse, error) {
	resp, err := l.GetLogic.Get(&types.GetKeyReq{
		Key: in.Key,
	})
	if err != nil {
		return nil, err
	}

	return &hellokv.GetResponse{
		Value: resp.Value,
	}, nil
}
```