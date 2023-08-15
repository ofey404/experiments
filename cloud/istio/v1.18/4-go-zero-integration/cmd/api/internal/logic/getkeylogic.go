package logic

import (
	"context"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/svc"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/types"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv2client"

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
	r, err := l.svcCtx.Rpc.Get(l.ctx, &hellokv2client.GetRequest{
		Key: req.Key,
	})
	if err != nil {
		return nil, err
	}

	return &types.GetKeyResp{
		Value: r.Value,
	}, nil
}
