package logic

import (
	"context"
	"database/sql"
	"errors"

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
	line, err := l.svcCtx.Model.Get(l.ctx, req.Key)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, errors.New("key not found")
		}
		return nil, err
	} else if line.Value.Valid == false {
		return nil, errors.New("value cant be null")
	}

	return &types.GetKeyResp{
		Value: line.Value.String,
	}, nil
}
