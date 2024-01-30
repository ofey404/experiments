package main

import "fmt"

func NewGetLogic(svcCtx *ServiceContext) func(GetRequest) (GetResponse, error) {
	return func(req GetRequest) (GetResponse, error) {
		v, ok := svcCtx.KV[req.Key]
		if !ok {
			return GetResponse{}, fmt.Errorf("key not found")
		}

		return GetResponse{Value: v}, nil
	}
}
