package logic

import (
	"context"

	"github.com/ofey404/experiments/microservices/go-zero/shared-proto/greeter2/greeter2"
	"github.com/ofey404/experiments/microservices/go-zero/shared-proto/greeter2/internal/svc"

	"github.com/zeromicro/go-zero/core/logx"
)

type SayHelloLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewSayHelloLogic(ctx context.Context, svcCtx *svc.ServiceContext) *SayHelloLogic {
	return &SayHelloLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Sends a greeting
func (l *SayHelloLogic) SayHello(in *greeter2.HelloRequest) (*greeter2.HelloReply, error) {
	// todo: add your logic here and delete this line

	return &greeter2.HelloReply{}, nil
}
