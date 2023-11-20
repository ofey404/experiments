package logic

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"

	"github.com/zeromicro/go-zero/core/logx"
)

type GetLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewGetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetLogic {
	return &GetLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *GetLogic) Get(in *hellokv.GetRequest) (*hellokv.GetResponse, error) {
	// todo: add your logic here and delete this line

	return &hellokv.GetResponse{}, nil
}
