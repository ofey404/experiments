package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, you've connected successfully!")
}

func main() {
	port := 443
	fmt.Printf("Starting server at :%d... ", port)
	http.HandleFunc("/", handler)
	err := http.ListenAndServeTLS(fmt.Sprintf(":%d", port), "cert.pem", "key.pem", nil)
	if err != nil {
		fmt.Println(err)
		return
	}
}
