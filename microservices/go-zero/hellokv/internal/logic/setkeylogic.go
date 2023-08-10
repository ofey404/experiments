package logic

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

type SetKeyLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewSetKeyLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SetKeyLogic {
	return &SetKeyLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *SetKeyLogic) SetKey(req *types.SetKeyReq) error {
	l.svcCtx.Kv[req.Key] = req.Value
	return nil
}
