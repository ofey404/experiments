package main

import (
	"context"
	"fmt"
	"testing"
)

var mockSvcCtx = &ServiceContext{
	KV: map[string]string{
		"foo": "bar",
	},
}

func TestGetLogic(t *testing.T) {
	tests := []TestLogicEntry[GetRequest, GetResponse]{
		{
			Name: "fail to get",
			TestLogic: func() Logic[GetRequest, GetResponse] {
				return NewGetLogic(context.Background(), mockSvcCtx)
			},
			Request:   GetRequest{Key: "not-exist"},
			WantError: fmt.Errorf("key not found"),
		},
		{
			Name: "get",
			TestLogic: func() Logic[GetRequest, GetResponse] {
				return NewGetLogic(context.Background(), mockSvcCtx)
			},
			Request:      GetRequest{Key: "foo"},
			WantResponse: GetResponse{Value: "bar"},
		},
	}

	TableLogicTest(t, tests)
}
