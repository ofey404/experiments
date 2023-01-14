package concurrency

import (
	"math/rand"
	"testing"
)

// generate random int
func BenchmarkPipelineOverhead(b *testing.B) {
	b.ReportAllocs()

	done := make(chan any)
	randomPipeline := take(done, repeatFn(done, func() any { return rand.Int() }), b.N)

	b.ResetTimer()
	for range randomPipeline {
	}
}

func BenchmarkControlGroup(b *testing.B) {
	b.ReportAllocs()
	b.ResetTimer()
	for n := 0; n < b.N; n++ {
		rand.Int()
	}
}
