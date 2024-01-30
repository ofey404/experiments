package main

import (
	"context"
	"fmt"
)

type GetLogic struct {
	ctx    context.Context
	svcCtx *ServiceContext
}

func NewGetLogic(ctx context.Context, svcCtx *ServiceContext) Logic[GetRequest, GetResponse] {
	return &GetLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

func (l GetLogic) Handle(req GetRequest) (GetResponse, error) {
	v, ok := l.svcCtx.KV[req.Key]
	if !ok {
		return GetResponse{}, fmt.Errorf("key not found")
	}

	return GetResponse{Value: v}, nil
}
