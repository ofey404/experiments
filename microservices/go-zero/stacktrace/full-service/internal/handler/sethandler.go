package handler

import (
	"net/http"

	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/logic"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func SetHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.SetRequest
		if err := httpx.Parse(r, &req); err != nil {
			httpx.Error(w, err)
			return
		}

		l := logic.NewSetLogic(r.Context(), svcCtx)
		err := l.Set(&req)
		if err != nil {
			httpx.Error(w, err)
		} else {
			httpx.Ok(w)
		}
	}
}
