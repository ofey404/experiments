package main

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

type TestLogicEntry[Request any, Response any] struct {
	Name         string
	TestLogic    func() Logic[Request, Response]
	Request      Request
	WantResponse Response
	WantError    error
}

func TableLogicTest[Request any, Response any](t *testing.T, tests []TestLogicEntry[Request, Response]) {
	t.Helper()
	for _, tt := range tests {
		t.Run(tt.Name, func(t *testing.T) {
			t.Helper()
			ast := assert.New(t)

			resp, err := tt.TestLogic().Handle(tt.Request)
			if tt.WantError != nil {
				ast.EqualError(err, tt.WantError.Error())
				return
			}

			ast.Nil(err)
			ast.Equal(tt.WantResponse, resp)
		})
	}
}
