package main

import (
	"fmt"

	"github.com/r3labs/sse/v2"
)

func main() {
	client := sse.NewClient("http://127.0.0.1:8080/events")

	_ = client.Subscribe("messages", func(msg *sse.Event) {
		// Got some data!
		fmt.Println(string(msg.Data))
	})
}
