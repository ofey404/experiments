package Api

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"

	"github.com/zeromicro/go-zero/core/logx"
)

type SetKeyApiLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewSetKeyApiLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SetKeyApiLogic {
	return &SetKeyApiLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l *SetKeyApiLogic) SetKeyApi(req *types.SetKeyReq) error {
	// todo: add your logic here and delete this line

	return nil
}
