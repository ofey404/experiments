package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/pkg/errors"
	"github.com/zeromicro/go-zero/rest/httpx"
	"nhooyr.io/websocket"
)

func main() {
	log.SetFlags(0)

	err := run()
	if err != nil {
		log.Fatal(err)
	}
}

// with all requests handled by EchoServer.
func run() error {
	if len(os.Args) < 2 {
		return errors.New("please provide an address to listen on as the first argument")
	}

	l, err := net.Listen("tcp", os.Args[1])
	if err != nil {
		return err
	}
	log.Printf("listening on http://%v", l.Addr())

	s := &http.Server{
		Handler: ErrorReturnServer{
			logf: log.Printf,
		},
		ReadTimeout:  time.Second * 10,
		WriteTimeout: time.Second * 10,
	}
	errc := make(chan error, 1)
	go func() {
		errc <- s.Serve(l)
	}()

	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, os.Interrupt)
	select {
	case err := <-errc:
		log.Printf("failed to serve: %v", err)
	case sig := <-sigs:
		log.Printf("terminating: %v", sig)
	}

	ctx, cancel := context.WithTimeout(context.Background(), time.Second*10)
	defer cancel()

	return s.Shutdown(ctx)
}

type ErrorReturnServer struct {
	// logf controls where logs are sent.
	logf func(f string, v ...interface{})
}

const hardCodeToken = "hardcoded token"

func (s ErrorReturnServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if tokenInvalid(w, r) {
		return
	}

	c, err := websocket.Accept(w, r, &websocket.AcceptOptions{
		Subprotocols: []string{"echo"},
	})
	if err != nil {
		s.logf("%v", err)
		return
	}
	defer c.Close(websocket.StatusInternalError, "the sky is falling")
}

func tokenInvalid(w http.ResponseWriter, r *http.Request) bool {
	var header struct {
		Token string `header:"token"`
	}
	if err := httpx.Parse(r, &header); err != nil {
		fmt.Printf("httpx.ParseHeaders: %v", err)
		httpx.Error(w, err)
		return true
	}
	if header.Token != hardCodeToken {
		fmt.Printf("invalid header.token value: %s", header.Token)
		httpx.Error(w, errors.Errorf("invalid header.token value: %s", header.Token))
		return true
	}
	return false
}
