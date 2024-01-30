package main

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"os"
)

func main() {
	router := gin.Default()

	svcCtx := NewServiceContext()

	router.POST("/set",
		NewJSONHandler(svcCtx, NewSetLogic),
	)
	router.POST("/get",
		NewJSONHandler(svcCtx, NewGetLogic),
	)

	err := router.Run()
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
}
