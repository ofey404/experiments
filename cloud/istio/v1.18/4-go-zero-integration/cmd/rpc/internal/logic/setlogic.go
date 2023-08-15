package logic

import (
	"context"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/hellokv"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/rpc/internal/svc"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/model"

	"github.com/zeromicro/go-zero/core/logx"
)

type SetLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewSetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SetLogic {
	return &SetLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *SetLogic) Set(in *hellokv.SetRequest) (*hellokv.SetResponse, error) {
	old_kvs, err := l.svcCtx.Model.FindByKey(l.ctx, in.Key)
	if err != model.ErrNotFound {
		for _, old := range old_kvs {
			_, err := l.svcCtx.Model.Delete(l.ctx, old.ID.Hex())
			if err != nil {
				return nil, err
			}
		}
	}

	kv := &model.HelloKv2{
		Key:   in.Key,
		Value: in.Value,
	}

	err = l.svcCtx.Model.Insert(l.ctx, kv)
	if err != nil {
		return nil, err
	}

	return &hellokv.SetResponse{}, nil
}
