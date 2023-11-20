package api

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

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
	l.svcCtx.Kv[req.Key] = req.Value
	return nil
}
