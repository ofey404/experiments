package logic

import (
	"context"
	"database/sql"
	"errors"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/config"

	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/svc"
	"github.com/ofey404/experiments/microservices/orm/sqlc/go-zero-postgres-flyway/internal/types"

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
	resp = &types.GetKeyResp{}

	if l.svcCtx.Config.SchemaVersion == config.SchemaVersionV1 {
		line, err := l.svcCtx.ModelV1.Get(l.ctx, req.Key)
		if err != nil {
			if errors.Is(err, sql.ErrNoRows) {
				return nil, errors.New("key not found")
			}
			return nil, err
		} else if line.Value.Valid == false {
			return nil, errors.New("value cant be null")
		}
		resp.Value = line.Value.String

	} else if l.svcCtx.Config.SchemaVersion == config.SchemaVersionV2 {
		line, err := l.svcCtx.ModelV2.Get(l.ctx, req.Key)
		if err != nil {
			if errors.Is(err, sql.ErrNoRows) {
				return nil, errors.New("key not found")
			}
			return nil, err
		}
		resp.Value = line.Value
	} else {
		return nil, errors.New("db schema version not supported")
	}

	return resp, nil
}
