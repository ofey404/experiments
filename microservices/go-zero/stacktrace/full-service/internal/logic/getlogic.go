package logic

import (
	"context"

	"github.com/pkg/errors"

	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/types"

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

func (l *GetLogic) Get(req *types.GetRequest) (resp *types.GetResponse, err error) {
	val, ok := l.svcCtx.Map[req.Key]
	if !ok {
		return nil, errors.New("key not found")
	}
	return &types.GetResponse{
		Value: val,
	}, nil
}
