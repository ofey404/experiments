package middleware

import (
	"net/http"

	"github.com/zeromicro/go-zero/core/trace"
)

type TraceIDMiddleware struct {
}

func NewTraceIDMiddleware() *TraceIDMiddleware {
	return &TraceIDMiddleware{}
}

func (m *TraceIDMiddleware) Handle(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		trace.TraceIDFromContext(r.Context())
		w.Header().Set("x-trace-id", trace.TraceIDFromContext(r.Context()))
		next(w, r)
	}
}
