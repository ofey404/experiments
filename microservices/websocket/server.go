package main

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/pkg/errors"
	"github.com/zeromicro/go-zero/rest/httpx"

	"golang.org/x/time/rate"

	"nhooyr.io/websocket"
)

// EchoServer is the WebSocket echo server implementation.
// It ensures the client speaks the echo subprotocol and
// only allows one message every 100ms with a 10 message burst.
type EchoServer struct {
	// logf controls where logs are sent.
	logf func(f string, v ...interface{})
}

const hardCodeToken = "hardcoded token"

func (s EchoServer) ServeHTTP(w http.ResponseWriter, r *http.Request) {
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

	if c.Subprotocol() != "echo" {
		_ = c.Close(websocket.StatusPolicyViolation, "client must speak the echo subprotocol")
		return
	}

	l := rate.NewLimiter(rate.Every(time.Millisecond*100), 10)
	for {
		err = echo(r.Context(), c, l)
		if websocket.CloseStatus(err) == websocket.StatusNormalClosure {
			return
		}
		if err != nil {
			s.logf("failed to echo with %v: %v", r.RemoteAddr, err)
			return
		}
	}
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

// echo reads from the WebSocket connection and then writes
// the received message back to it.
// The entire function has 10s to complete.
func echo(ctx context.Context, c *websocket.Conn, l *rate.Limiter) error {
	ctx, cancel := context.WithTimeout(ctx, time.Second*10)
	defer cancel()

	err := l.Wait(ctx)
	if err != nil {
		return err
	}

	typ, r, err := c.Reader(ctx)
	if err != nil {
		return err
	}

	w, err := c.Writer(ctx, typ)
	if err != nil {
		return err
	}

	_, err = io.Copy(w, r)
	if err != nil {
		return fmt.Errorf("failed to io.Copy: %w", err)
	}

	err = w.Close()
	return err
}
