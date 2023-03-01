package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", readme)
	err := http.ListenAndServe(":8080", nil) // #nosec
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func readme(res http.ResponseWriter, req *http.Request) {
	http.ServeFile(res, req, "./files/readme.txt")
}
