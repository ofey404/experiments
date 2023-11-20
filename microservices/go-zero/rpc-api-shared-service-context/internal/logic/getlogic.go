package logic

import (
	"context"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/logic/api"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/hellokv"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
)

type GetLogic struct {
	*api.GetLogic
}

func NewGetLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetLogic {
	return &GetLogic{
		GetLogic: api.NewGetLogic(ctx, svcCtx),
	}
}

func (l *GetLogic) Get(in *hellokv.GetRequest) (*hellokv.GetResponse, error) {
	resp, err := l.GetLogic.Get(&types.GetKeyReq{
		Key: in.Key,
	})
	if err != nil {
		return nil, err
	}

	return &hellokv.GetResponse{
		Value: resp.Value,
	}, nil
}
