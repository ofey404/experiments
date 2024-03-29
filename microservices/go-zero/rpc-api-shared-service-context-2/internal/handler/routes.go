// Code generated by goctl. DO NOT EDIT.
package handler

import (
	"net/http"

	api "github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/handler/api"
	"github.com/ofey404/experiments/microservices/go-zero/rpc-api-shared-service-context-2/internal/svc"

	"github.com/zeromicro/go-zero/rest"
)

func RegisterHandlers(server *rest.Server, serverCtx *svc.ServiceContext) {
	server.AddRoutes(
		[]rest.Route{
			{
				Method:  http.MethodPost,
				Path:    "/getkey",
				Handler: api.GetHandler(serverCtx),
			},
			{
				Method:  http.MethodPost,
				Path:    "/setkey",
				Handler: api.SetHandler(serverCtx),
			},
		},
	)
}
