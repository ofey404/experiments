package logic

import (
	"context"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/svc"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/types"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv2client"

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
	// todo: add your logic here and delete this line
	_, err := l.svcCtx.Rpc.Set(l.ctx, &hellokv2client.SetRequest{
		Key:   req.Key,
		Value: req.Value,
	})
	if err != nil {
		return err
	}

	return nil
}
