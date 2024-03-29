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
	Name:
		%s
	DeprecateByReserve:
		%s
	DeprecateByMark:
		%s
	ChangeFieldType:
		%s
	ChangeToArrayByAddRepeated:
		%s
	ChangeIntoArrayByReserveAndAddANewField:
		%s
`,
		in.GetName(),
		in.GetDeprecateByReserve(),
		in.GetDeprecateByMark(),
		in.GetChangeFieldType(),
		in.GetChangeToArrayByAddRepeated(),
		in.GetChangeIntoArrayByReserveAndAddANewField(),
	)

	return &HelloReply{Message: "Hello " + in.GetName()}, nil
}
