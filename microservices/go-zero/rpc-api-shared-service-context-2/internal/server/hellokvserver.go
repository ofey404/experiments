// Code generated by goctl. DO NOT EDIT.
// Source: hellokv.proto

package server

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/logic"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/svc"
)

type HellokvServer struct {
	svcCtx *svc.ServiceContext
	hellokv.UnimplementedHellokvServer
}

func NewHellokvServer(svcCtx *svc.ServiceContext) *HellokvServer {
	return &HellokvServer{
		svcCtx: svcCtx,
	}
}

func (s *HellokvServer) Get(ctx context.Context, in *hellokv.GetRequest) (*hellokv.GetResponse, error) {
	l := logic.NewGetLogic(ctx, s.svcCtx)
	return l.Get(in)
}

func (s *HellokvServer) Set(ctx context.Context, in *hellokv.SetRequest) (*hellokv.SetResponse, error) {
	l := logic.NewSetLogic(ctx, s.svcCtx)
	return l.Set(in)
}
