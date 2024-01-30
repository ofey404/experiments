package main

import (
	"context"
	"github.com/gin-gonic/gin"
	"net/http"
)

// Handler has a per-service lifecycle.
// Logic is created per-request.

func NewJSONHandler[Request any, Response any](
	svcCtx *ServiceContext,
	newLogic func(context.Context, *ServiceContext) Logic[Request, Response],
) gin.HandlerFunc {
	return func(c *gin.Context) {
		var req Request
		// TODO: validation
		if err := c.ShouldBindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		resp, err := newLogic(c.Request.Context(), svcCtx).Handle(req)
		if err != nil {
			// TODO: more error handling
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, resp)
	}
}
