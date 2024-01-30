package main

func NewSetLogic(svcCtx *ServiceContext) func(SetRequest) (EmptyResponse, error) {
	return func(req SetRequest) (EmptyResponse, error) {
		svcCtx.KV[req.Key] = req.Value

		return EmptyResponse{}, nil
	}
}
