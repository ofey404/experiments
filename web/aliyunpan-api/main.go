package main

import (
	"fmt"
	"os"

	"github.com/tickstep/aliyunpan-api/aliyunpan_open"
	"github.com/tickstep/aliyunpan-api/aliyunpan_open/openapi"
)

func main() {
	token := os.Getenv("ACCESS_TOKEN")
	if token == "" {
		fmt.Println("ACCESS_TOKEN is empty")
	}
	fmt.Printf("ACCESS_TOKEN: %s\n", token)

	openPanClient := aliyunpan_open.NewOpenPanClient(openapi.ApiConfig{
		TicketId:     "",
		UserId:       "",
		ClientId:     "",
		ClientSecret: "",
	}, openapi.ApiToken{
		AccessToken: token,
		ExpiredAt:   0,
	}, nil)

	// get user info
	ui, err := openPanClient.GetUserInfo()
	if err != nil {
		fmt.Println("get user info error")
		return
	}
	fmt.Println("当前登录用户：" + ui.Nickname)

	// do some file operation
	fi, _ := openPanClient.FileInfoByPath(ui.FileDriveId, "/我的文档")
	fmt.Println("\n我的文档 信息：")
	fmt.Println(fi)
}
