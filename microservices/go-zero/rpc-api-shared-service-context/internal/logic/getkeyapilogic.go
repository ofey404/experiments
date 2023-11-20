package logic

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

type GetKeyApiLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewGetKeyApiLogic(ctx context.Context, svcCtx *svc.ServiceContext) *GetKeyApiLogic {
	return &GetKeyApiLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *GetKeyApiLogic) GetKeyApi(req *types.GetKeyReq) (resp *types.GetKeyResp, err error) {
	// todo: add your logic here and delete this line

	return
}
