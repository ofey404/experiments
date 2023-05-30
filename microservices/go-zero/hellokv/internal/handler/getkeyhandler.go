package handler

import (
	"net/http"

	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/logic"
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/hellokv/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func GetKeyHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.GetKeyReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.Error(w, err)
			return
		}

		l := logic.NewGetKeyLogic(r.Context(), svcCtx)
		resp, err := l.GetKey(&req)
		if err != nil {
			httpx.Error(w, err)
		} else {
			httpx.OkJson(w, resp)
		}
	}
}
