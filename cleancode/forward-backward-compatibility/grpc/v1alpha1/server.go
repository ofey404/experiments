package v1alpha1

import (
	"context"
	"fmt"
)

type Server struct {
	UnimplementedGreeterServer
}

func (s *Server) SayHello(ctx context.Context, in *HelloRequest) (*HelloReply, error) {
	fmt.Printf(`Received request:
	Name: %s
	ThisWouldBeDeprecated: %s
	ThisWouldChangeIntoArray: %s
	BetterWayToChangeIntoArray: %s
`,
		in.GetName(),
		in.GetThisWouldBeDeprecated(),
		in.GetThisWouldChangeIntoArray(),
		in.GetBetterWayToChangeIntoArray(),
	)

	return &HelloReply{Message: "Hello " + in.GetName()}, nil
}
