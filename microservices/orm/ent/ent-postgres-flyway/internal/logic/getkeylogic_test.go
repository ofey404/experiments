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
	// Unit test with an in-memory sqlite.
	// https://github.com/ent/ent/issues/217
	ast := assert.New(t)

	// CAUTION: There could be only 1 connection to the in-memory sqlite at the same time.
	// 			So that during svcCtx.Client.Close(), we can clean up the sqlite data.
	//          Otherwise, there would be dirty data across the test.
	client, err := ent.Open("sqlite3", "file:ent?mode=memory&cache=shared&_fk=1")
	ast.Nil(err)

	// create schema
	ast.Nil(client.Schema.Create(context.Background()))

	return &svc.ServiceContext{
		Client: client,
	}
}

func newMockGetLogic(t *testing.T, exp ...func(*svc.ServiceContext)) func(req *types.GetKeyReq) (resp *types.GetKeyResp, err error) {
	return func(req *types.GetKeyReq) (resp *types.GetKeyResp, err error) {
		svcCtx := newMockServiceContext(t)
		for _, e := range exp {
			e(svcCtx)
		}
		resp, err = NewGetKeyLogic(context.Background(), svcCtx).GetKey(req)

		// close the client, to clean up the sqlite data
		assert.Nil(t, svcCtx.Client.Close())
		return resp, err
	}
}

func TestGetKeyLogic_GetKey(t *testing.T) {
	ast := assert.New(t)
	tests := []struct {
		Name            string
		Logic           func(req *types.GetKeyReq) (resp *types.GetKeyResp, err error)
		Req             *types.GetKeyReq
		WantResp        *types.GetKeyResp
		WantErrContains string
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
		{
			Name:  "key not found",
			Logic: newMockGetLogic(t),
			Req: &types.GetKeyReq{
				Key: "key",
			},
			WantErrContains: "key not found",
		},
	}

	for _, tt := range tests {
		t.Run(
			tt.Name,
			func(t *testing.T) {
				ast := assert.New(t)
				resp, err := tt.Logic(tt.Req)
				if tt.WantErrContains != "" {
					ast.ErrorContains(err, tt.WantErrContains)
					return
				}
				ast.Nil(err)

				ast.Equal(tt.WantResp, resp)
			},
		)
	}
}
