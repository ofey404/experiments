package logic

import (
	"context"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/logic/api"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
)

type SetLogic struct {
	*api.SetLogic
}

func NewSetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SetLogic {
	return &SetLogic{
		SetLogic: api.NewSetLogic(ctx, svcCtx),
	}
}

func (l *SetLogic) Set(in *hellokv.SetRequest) (*hellokv.SetResponse, error) {
	err := l.SetLogic.Set(&types.SetKeyReq{
		Key:   in.Key,
		Value: in.Value,
	})
	if err != nil {
		return nil, err
	}

	return &hellokv.SetResponse{}, nil
}
