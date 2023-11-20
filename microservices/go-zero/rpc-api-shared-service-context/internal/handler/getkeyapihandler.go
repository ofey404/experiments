package handler

import (
	"net/http"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/logic"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func GetKeyApiHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.GetKeyReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := logic.NewGetKeyApiLogic(r.Context(), svcCtx)
		resp, err := l.GetKeyApi(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.OkJsonCtx(r.Context(), w, resp)
		}
	}
}
