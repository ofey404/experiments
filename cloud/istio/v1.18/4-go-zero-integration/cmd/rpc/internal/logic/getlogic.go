package logic

import (
	"context"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/internal/svc"
	"gopkg.in/errgo.v2/fmt/errors"

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
	kvs, err := l.svcCtx.Model.FindByKey(l.ctx, in.Key)
	if err != nil {
		return nil, err
	}

	if len(kvs) == 0 {
		return nil, errors.New("not found")
	}
	if len(kvs) > 1 {
		return nil, errors.New("more than one")
	}

	return &hellokv.GetResponse{
		Value: kvs[0].Value,
	}, nil
}
