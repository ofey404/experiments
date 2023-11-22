package logic

import (
	"context"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent/kvpair"

	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/svc"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/types"

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
	notFound := false
	kv, err := l.svcCtx.Client.KVPair.
		Query().
		Where(kvpair.Key(req.Key)).
		Only(l.ctx)
	if err != nil {
		if ent.IsNotFound(err) {
			notFound = true
		} else {
			return err
		}
	}

	switch notFound {
	case true:
		_, err = l.svcCtx.Client.KVPair.
			Create().
			SetKey(req.Key).
			SetValue(req.Value).
			Save(l.ctx)
		if err != nil {
			return err
		}
	case false:
		_, err = l.svcCtx.Client.KVPair.
			UpdateOne(kv).
			SetValue(req.Value).
			Save(l.ctx)
		if err != nil {
			return err
		}
	}
	return nil
}
