package logic

import (
	"context"
	_ "github.com/mattn/go-sqlite3"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/ent"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/svc"
	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/types"
	"github.com/stretchr/testify/assert"
	"testing"
)

func newMockServiceContext(t *testing.T) *svc.ServiceContext {
	// Unit test with an in-memory sqlite
	// https://github.com/ent/ent/issues/217
	ast := assert.New(t)
	client, err := ent.Open("sqlite3", "file:ent?mode=memory&cache=shared&_fk=1")
	ast.Nil(err)

	// create schema
	ast.Nil(client.Schema.Create(context.Background()))

	return &svc.ServiceContext{
		Client: client,
	}
}

func newMockGetLogic(t *testing.T, exp ...func(*svc.ServiceContext)) *GetKeyLogic {
	svcCtx := newMockServiceContext(t)
	for _, e := range exp {
		e(svcCtx)
	}

	return NewGetKeyLogic(context.Background(), svcCtx)
}

func TestGetKeyLogic_GetKey(t *testing.T) {
	ast := assert.New(t)
	tests := []struct {
		Name     string
		Logic    *GetKeyLogic
		Req      *types.GetKeyReq
		WantResp *types.GetKeyResp
		WantErr  error
	}{
		{
			Name: "get key",
			Logic: newMockGetLogic(t,
				func(svcCtx *svc.ServiceContext) {
					_, err := svcCtx.Client.KVPair.Create().SetKey("key").SetValue("value").Save(context.Background())
					ast.Nil(err)
				},
			),
			Req: &types.GetKeyReq{
				Key: "key",
			},
			WantResp: &types.GetKeyResp{
				Value: "value",
			},
		},
	}

	for _, tt := range tests {
		t.Run(
			tt.Name,
			func(t *testing.T) {
				ast := assert.New(t)
				resp, err := tt.Logic.GetKey(tt.Req)
				if tt.WantErr != nil {
					ast.EqualError(err, tt.WantErr.Error())
					return
				}
				ast.Nil(err)

				ast.Equal(tt.WantResp, resp)
			},
		)
	}
}
