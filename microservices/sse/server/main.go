package main

import (
	"log"
	"net/http"
	"time"

	"github.com/r3labs/sse/v2"
)

func main() {
	server := sse.New()

	server.CreateStream("messages")

	go func() {
		for {
			// Publish a payload to the stream
			server.Publish("messages", &sse.Event{
				Data: []byte("ping"),
			})
			log.Print("published event ping")
			time.Sleep(time.Second)
		}
	}()

	// Create a new Mux and set the handler
	mux := http.NewServeMux()
	mux.HandleFunc("/events", server.ServeHTTP)

	log.Printf("listening on http://localhost:8080")
	_ = http.ListenAndServe(":8080", mux) // #nosec
}