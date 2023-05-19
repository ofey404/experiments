package main

import (
	"context"
	"log"
	"io"
	"net"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/pkg/errors"
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
		Handler: BinaryMessageServer{
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

type BinaryMessageServer struct {
	// logf controls where logs are sent.
	logf func(f string, v ...interface{})
}

func (s BinaryMessageServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	c, err := websocket.Accept(w, r, &websocket.AcceptOptions{
			CompressionMode:    websocket.CompressionDisabled,
	})
	if err != nil {
		s.logf("%v", err)
		return
	}
	defer c.Close(websocket.StatusNormalClosure, "normal closure")

	f, err := os.Open("./data.log")
	if err != nil {
		s.logf("%v", err)
		return
	}
	defer f.Close()
	buf := make([]byte, 2000)
	for {
		n, err := f.Read(buf)
		if err != nil {
			if err != io.EOF {
				s.logf("%v", err)
			}
			break
		}
		err = c.Write(r.Context(), websocket.MessageBinary, buf[:n])
		if err != nil {
			s.logf("%v", err)
			break
		}
	}

}
