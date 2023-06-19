package main

import (
	"fmt"
	"net/http"
	"strings"
	"time"
)

func escape(input string) string {
	return strings.ReplaceAll(input, "\n", "\\n")
}

func multi_line_data() string {
	return escape(
		fmt.Sprintf("Multiline data\ntime:\n%s\n", time.Now().Format(time.RFC3339)),
	)
}

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
	_, _ = fmt.Fprintf(w, "data: %s\n\n", multi_line_data())

	// Continuously send updates to the client
	for {
		time.Sleep(1 * time.Second)
		_, _ = fmt.Fprintf(w, "data: %s\n\n", multi_line_data())
		w.(http.Flusher).Flush()
	}
}
