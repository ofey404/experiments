package logic

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/types"

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

func (l *SetLogic) Set(req *types.SetRequest) error {
	l.svcCtx.Map[req.Key] = req.Value
	return nil
}
