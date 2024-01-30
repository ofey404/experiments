package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func NewHandler[Req any, Resp any](
	svcCtx *ServiceContext,
	newLogic func(*ServiceContext) func(Req) (Resp, error),
) gin.HandlerFunc {
	return func(c *gin.Context) {
		var req Req
		// TODO: validation
		if err := c.ShouldBindJSON(&req); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}

		resp, err := newLogic(svcCtx)(req)
		if err != nil {
			// TODO: more error handling
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}

		c.JSON(http.StatusOK, resp)
	}
}
