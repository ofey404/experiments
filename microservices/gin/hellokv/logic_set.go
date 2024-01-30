package main

import "context"

type SetLogic struct {
	ctx    context.Context
	svcCtx *ServiceContext
}

func NewSetLogic(ctx context.Context, svcCtx *ServiceContext) Logic[SetRequest, EmptyResponse] {
	return &SetLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l SetLogic) Handle(req SetRequest) (EmptyResponse, error) {
	l.svcCtx.KV[req.Key] = req.Value

	return EmptyResponse{}, nil
}
