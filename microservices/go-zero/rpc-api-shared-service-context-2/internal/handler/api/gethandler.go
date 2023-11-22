package api

import (
	"net/http"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/logic/api"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func GetHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.GetKeyReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := api.NewGetLogic(r.Context(), svcCtx)
		resp, err := l.Get(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
