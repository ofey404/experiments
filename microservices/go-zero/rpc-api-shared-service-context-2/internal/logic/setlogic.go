package logic

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/svc"

	"github.com/zeromicro/go-zero/core/logx"
)

type SetLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewSetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SetLogic {
	return &SetLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *SetLogic) Set(in *hellokv.SetRequest) (*hellokv.SetResponse, error) {
	// todo: add your logic here and delete this line

	return &hellokv.SetResponse{}, nil
}
