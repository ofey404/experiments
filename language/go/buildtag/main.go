package main

import "fmt"

func main() {
	fmt.Println("AppVersion:", AppVersion)
}

// go run .
// AppVersion: dev
//
// go run -tags=prod .
// AppVersion: prod
