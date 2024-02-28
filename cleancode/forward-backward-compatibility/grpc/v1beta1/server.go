package v1beta1

import (
	"context"
	"fmt"
)

type Server struct {
	UnimplementedGreeterServer
}

func (s *Server) SayHello(ctx context.Context, in *HelloRequest) (*HelloReply, error) {
	fmt.Printf(`Received request:
	Name:
		%s
	DeprecateByMark:
		%s
	ChangeFieldType:
		%d (int64)
	ChangeToArrayByAddRepeated:
		%s
	ChangeIntoArrayByReserveAndAddANewField:
		%s
`,
		in.GetName(),
		in.GetDeprecateByMark(),
		in.GetChangeFieldType(),
		in.GetChangeToArrayByAddRepeated(),
		in.GetChangeIntoArrayByReserveAndAddANewField(),
	)

	return &HelloReply{Message: "Hello " + in.GetName()}, nil
}
