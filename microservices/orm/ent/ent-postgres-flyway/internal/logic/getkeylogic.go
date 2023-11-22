package logic

import (
	"context"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent/kvpair"
	"github.com/pkg/errors"

	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/svc"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/types"

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
	kv, err := l.svcCtx.Client.KVPair.
		Query().
		Where(kvpair.Key(req.Key)).
		Only(l.ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			return nil, errors.New("key not found")
		}
		return nil, err
	}

	return &types.GetKeyResp{
		Value: kv.Value,
	}, nil
}
