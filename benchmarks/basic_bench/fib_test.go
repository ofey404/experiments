package basic_bench

import (
	"testing"
)

func BenchmarkFib(b *testing.B) {
	b.ReportAllocs()

	// prepare

	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		Fib(30) // run fib(30) b.N times
	}
}
