package handler

import (
	"net/http"

	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/logic"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/svc"
	"github.com/ofey404/experiments/cloud/istio/v1.18/4-go-zero-integration/cmd/api/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func SetKeyHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.SetKeyReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := logic.NewSetKeyLogic(r.Context(), svcCtx)
		err := l.SetKey(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.Ok(w)
		}
	}
}
