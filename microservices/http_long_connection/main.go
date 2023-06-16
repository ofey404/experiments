package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	http.HandleFunc("/", handle)
	fmt.Printf("Listening on localhost:8080\n")
	_ = http.ListenAndServe(":8080", nil)
}

func handle(w http.ResponseWriter, r *http.Request) {
	// Set headers for long polling connection
	w.Header().Set("Content-Type", "text/event-stream")
	w.Header().Set("Cache-Control", "no-cache")
	w.Header().Set("Connection", "keep-alive")
	w.Header().Set("Access-Control-Allow-Origin", "*")

	// Send initial data to the client
	_, _ = fmt.Fprintf(w, "data: %s\n\n", time.Now().Format(time.RFC3339))

	// Continuously send updates to the client
	for {
		time.Sleep(1 * time.Second)
		_, _ = fmt.Fprintf(w, "data: %s\n\n", time.Now().Format(time.RFC3339))
		w.(http.Flusher).Flush()
	}
}
