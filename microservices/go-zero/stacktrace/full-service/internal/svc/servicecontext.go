package svc

import (
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/config"
	"github.com/ofey404/experiments/microservices/go-zero/stacktrace/full-service/internal/middleware"
	"github.com/zeromicro/go-zero/rest"
)

type ServiceContext struct {
	Config            config.Config
	Map               map[string]string
	TraceIDMiddleware rest.Middleware
}

func NewServiceContext(c config.Config) *ServiceContext {
	return &ServiceContext{
		Config:            c,
		Map:               make(map[string]string),
		TraceIDMiddleware: middleware.NewTraceIDMiddleware().Handle,
	}
}
