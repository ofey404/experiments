package api

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

type SetLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewSetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SetLogic {
	return &SetLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *SetLogic) Set(req *types.SetKeyReq) error {
	// todo: add your logic here and delete this line

	return nil
}
