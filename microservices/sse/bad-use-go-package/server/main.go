package main

import (
	"log"
	"net"
	"net/http"
	"net/http/httptest"

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

	l, err := net.Listen("tcp", "0.0.0.0:8080")
	if err != nil {
		log.Fatal(err)
	}

	ts := httptest.NewUnstartedServer(mux)
	ts.Listener.Close()
	ts.Listener = l
	ts.Start()
	defer ts.Close()

	go func() {
		for {
			log.Printf("Close Client Connections")
			ts.CloseClientConnections()
			time.Sleep(5 * time.Second)
		}
	}()

	log.Printf("listening on http://0.0.0.0:8080")
	time.Sleep(time.Hour * 9999)
}
