package json_marshal_performance

import (
	"encoding/json"
	"fmt"
	"testing"
)

// CodeError
type CodeError struct {
	Code    int32             `json:"code"`
	Message string            `json:"message"`
	Details map[string]string `json:"details,omitempty"`
}

var e = CodeError{
	Code:    200,
	Message: "This is a test error",
	Details: map[string]string{
		"cause": "detail",
	},
}

func Marshal() string {
	b, err := json.Marshal(e)
	if err != nil {
		panic(err)
	}
	return string(b)
}

func SprintfReflection() string {
	return fmt.Sprintf("%+v", e)
}

func Sprintf() string {
	return fmt.Sprintf("{ code: %d, message: %s, detail: %s, %s}", e.Code, e.Message, "cause", e.Details["cause"])
}

func bench(b *testing.B, f func() string) {
	b.ReportAllocs()
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		f()
	}
}

func BenchmarkMarshal(b *testing.B) {
	bench(b, Marshal)
}

func BenchmarkPrintfReflection(b *testing.B) {
	bench(b, SprintfReflection)
}

func BenchmarkPrintfSimple(b *testing.B) {
	bench(b, Sprintf)
}
