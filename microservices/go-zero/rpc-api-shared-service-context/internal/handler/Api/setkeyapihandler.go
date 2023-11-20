package Api

import (
	"net/http"

	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/logic/Api"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/svc"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context/internal/types"
	"github.com/zeromicro/go-zero/rest/httpx"
)

func SetKeyApiHandler(svcCtx *svc.ServiceContext) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var req types.SetKeyReq
		if err := httpx.Parse(r, &req); err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
			return
		}

		l := Api.NewSetKeyApiLogic(r.Context(), svcCtx)
		err := l.SetKeyApi(&req)
		if err != nil {
			httpx.ErrorCtx(r.Context(), w, err)
		} else {
			httpx.Ok(w)
		}
	}
}
