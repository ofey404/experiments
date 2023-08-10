package logic

import (
	"context"
	"errors"

	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

type GetKeyLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewGetKeyLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetKeyLogic {
	return &GetKeyLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *GetKeyLogic) GetKey(req *types.GetKeyReq) (resp *types.GetKeyResp, err error) {
	val, ok := l.svcCtx.Kv[req.Key]

	if !ok {
		return nil, errors.New("key not found")
	}

	return &types.GetKeyResp{
		Value: val,
	}, nil
}
