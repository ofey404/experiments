package concurrency

import (
	"math/rand"
	"testing"
)

// generate random int
func benchmarkPipeline(level int, b *testing.B) {
	b.ReportAllocs()

	done := make(chan any)
	randomPipeline := MultiLevelPipeline(done, level, b.N)

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

func BenchmarkPipeline1(b *testing.B) {
	benchmarkPipeline(1, b)
}

func BenchmarkPipeline2(b *testing.B) {
	benchmarkPipeline(2, b)
}

func BenchmarkPipeline10(b *testing.B) {
	benchmarkPipeline(10, b)
}

func BenchmarkPipeline100(b *testing.B) {
	benchmarkPipeline(100, b)
}

func BenchmarkPipeline1000(b *testing.B) {
	benchmarkPipeline(1000, b)
}
