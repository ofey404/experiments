package api

import (
	"context"
	"github.com/pkg/errors"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

type GetLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewGetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetLogic {
	return &GetLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *GetLogic) Get(req *types.GetKeyReq) (resp *types.GetKeyResp, err error) {
	val, ok := l.svcCtx.Kv[req.Key]
	if !ok {
		return nil, errors.New("key not found")
	}
	return &types.GetKeyResp{
		Value: val,
	}, nil
}
