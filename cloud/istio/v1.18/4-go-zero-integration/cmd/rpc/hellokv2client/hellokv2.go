// Code generated by goctl. DO NOT EDIT.
// Source: hellokv2.proto

package hellokv2client

import (
	"context"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv2"

	"github.com/zeromicro/go-zero/zrpc"
	"google.golang.org/grpc"
)

type (
	GetRequest  = hellokv2.GetRequest
	GetResponse = hellokv2.GetResponse
	SetRequest  = hellokv2.SetRequest
	SetResponse = hellokv2.SetResponse

	Hellokv2 interface {
		Get(ctx context.Context, in *GetRequest, opts ...grpc.CallOption) (*GetResponse, error)
		Set(ctx context.Context, in *SetRequest, opts ...grpc.CallOption) (*SetResponse, error)
	}

	defaultHellokv2 struct {
		cli zrpc.Client
	}
)

func NewHellokv2(cli zrpc.Client) Hellokv2 {
	return &defaultHellokv2{
		cli: cli,
	}
}

func (m *defaultHellokv2) Get(ctx context.Context, in *GetRequest, opts ...grpc.CallOption) (*GetResponse, error) {
	client := hellokv2.NewHellokv2Client(m.cli.Conn())
	return client.Get(ctx, in, opts...)
}

func (m *defaultHellokv2) Set(ctx context.Context, in *SetRequest, opts ...grpc.CallOption) (*SetResponse, error) {
	client := hellokv2.NewHellokv2Client(m.cli.Conn())
	return client.Set(ctx, in, opts...)
}
