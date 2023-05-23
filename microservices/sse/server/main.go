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
	server.Headers["Access-Control-Allow-Origin"] = "*"

	go func() {
		for {
			// Publish a payload to the stream
			server.Publish("messages", &sse.Event{
				Data: []byte("ping with linebreak\n"),
			})
			log.Print("published event ping")
			time.Sleep(time.Second)
		}
	}()

	// Create a new Mux and set the handler
	mux := http.NewServeMux()
	mux.HandleFunc("/events", server.ServeHTTP)

	log.Printf("listening on http://0.0.0.0:8080")
	err := http.ListenAndServe("0.0.0.0:8080", mux) // #nosec
	if err != nil {
		log.Printf("err = %+v\n", err)
	}
}
