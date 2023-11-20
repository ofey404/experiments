package logic

import (
	"context"
	"database/sql"
	"errors"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/config"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/svc"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/types"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/model/modelv1"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/model/modelv2"

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
	if l.svcCtx.Config.SchemaVersion == config.SchemaVersionV1 {
		_, err := l.svcCtx.ModelV1.Set(l.ctx, modelv1.SetParams{
			Key:   req.Key,
			Value: toNullString(req.Value),
		})
		if err != nil {
			return err
		}
	} else if l.svcCtx.Config.SchemaVersion == config.SchemaVersionV2 {
		_, err := l.svcCtx.ModelV2.Set(l.ctx, modelv2.SetParams{
			Key:   req.Key,
			Value: req.Value,
		})
		if err != nil {
			return err
		}
	} else {
		return errors.New("db schema version not supported")
	}

	return nil
}

func toNullString(s string) sql.NullString {
	if s == "" {
		return sql.NullString{
			String: "",
			Valid:  false,
		}
	}
	return sql.NullString{
		String: s,
		Valid:  true,
	}
}
