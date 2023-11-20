package logic

import (
	"context"
	"database/sql"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/model/modelv1"

	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/svc"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/types"

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
	_, err := l.svcCtx.Model.Set(l.ctx, modelv1.SetParams{
		Key:   req.Key,
		Value: toNullString(req.Value),
	})
	if err != nil {
		return err
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
