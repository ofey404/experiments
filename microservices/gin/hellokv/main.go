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
		NewHandler[SetRequest, EmptyResponse](svcCtx, NewSetLogic),
	)
	router.POST("/get",
		NewHandler[GetRequest, GetResponse](svcCtx, NewGetLogic),
	)

	err := router.Run()
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
}
