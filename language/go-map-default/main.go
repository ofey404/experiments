package main

import (
	"fmt"
)

func main() {
	var SubscriberCount map[string]int
	SubscriberCount["publisher_name"]++
	fmt.Printf("%+v\n", SubscriberCount)
	// fmt.Printf("%+v\n", SubscriberCount["publisher_name"])
}