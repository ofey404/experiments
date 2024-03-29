// Code generated by goctl. DO NOT EDIT.
package handler

import (
	"net/http"

	"github.com/ofey404/experiments/microservices/orm/ent/ent-postgres-flyway/internal/svc"

	"github.com/zeromicro/go-zero/rest"
)

func RegisterHandlers(server *rest.Server, serverCtx *svc.ServiceContext) {
	server.AddRoutes(
		[]rest.Route{
			{
				Method:  http.MethodPost,
				Path:    "/getkey",
				Handler: GetKeyHandler(serverCtx),
			},
			{
				Method:  http.MethodPost,
				Path:    "/setkey",
				Handler: SetKeyHandler(serverCtx),
			},
		},
	)
}
