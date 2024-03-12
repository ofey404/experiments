package benchmark

import (
	"sync"
	"sync/atomic"
	"testing"

	"github.com/cornelk/hashmap"
)

// benchmark skeleton is from github.com/cornelk/hashmap

const benchmarkItemCount = 1024

func setupMap(b *testing.B) map[uintptr]uintptr {
	b.Helper()

	m := make(map[uintptr]uintptr)
	for i := uintptr(0); i < benchmarkItemCount; i++ {
		m[i] = i
	}
	return m
}

func setupSyncMap(b *testing.B) *sync.Map {
	b.Helper()

	m := &sync.Map{}
	for i := uintptr(0); i < benchmarkItemCount; i++ {
		m.Store(i, i)
	}
	return m
}

func setupHashMap(b *testing.B) *hashmap.Map[uintptr, uintptr] {
	b.Helper()

	m := hashmap.New[uintptr, uintptr]()
	for i := uintptr(0); i < benchmarkItemCount; i++ {
		m.Set(i, i)
	}
	return m
}

// ##################################################################
// Concurrent read benchmarks
// ##################################################################

// BenchmarkReadMapUint is for map with a RWMutex
func BenchmarkReadMapUint(b *testing.B) {
	m := setupMap(b)
	mu := &sync.RWMutex{}
	b.ResetTimer()

	b.RunParallel(func(pb *testing.PB) {
		for pb.Next() {
			for i := uintptr(0); i < benchmarkItemCount; i++ {
				mu.RLock()
				v, ok := m[i]
				mu.RUnlock()
				if !ok || v != i {
					b.Fail()
				}
			}
		}
	})
}

// BenchmarkReadSyncMapUint is for sync.Map
func BenchmarkReadSyncMapUint(b *testing.B) {
	m := setupSyncMap(b)
	b.ResetTimer()

	b.RunParallel(func(pb *testing.PB) {
		for pb.Next() {
			for i := uintptr(0); i < benchmarkItemCount; i++ {
				v, ok := m.Load(i)
				if !ok || v.(uintptr) != i {
					b.Fail()
				}
			}
		}
	})
}

// BenchmarkReadHashMapUint is for cornelk/hashmap
func BenchmarkReadHashMapUint(b *testing.B) {
	m := setupHashMap(b)
	b.ResetTimer()

	b.RunParallel(func(pb *testing.PB) {
		for pb.Next() {
			for i := uintptr(0); i < benchmarkItemCount; i++ {
				j, _ := m.Get(i)
				if j != i {
					b.Fail()
				}
			}
		}
	})
}

// ##################################################################
// Concurrent read and 1 write benchmarks
// ##################################################################

// map
func BenchmarkReadMapWithWritesUint(b *testing.B) {
	m := setupMap(b)
	mu := &sync.RWMutex{}
	var writer uintptr
	b.ResetTimer()

	b.RunParallel(func(pb *testing.PB) {
		// use 1 thread as writer
		if atomic.CompareAndSwapUintptr(&writer, 0, 1) {
			for pb.Next() {
				for i := uintptr(0); i < benchmarkItemCount; i++ {
					mu.Lock()
					m[i] = i
					mu.Unlock()
				}
			}
		} else {
			for pb.Next() {
				for i := uintptr(0); i < benchmarkItemCount; i++ {
					mu.RLock()
					j, ok := m[i]
					mu.RUnlock()
					if !ok || j != i {
						b.Fail()
					}
				}
			}
		}
	})
}

// sync.Map
func BenchmarkReadSyncMapWithWritesUint(b *testing.B) {
	m := setupSyncMap(b)
	var writer uintptr
	b.ResetTimer()

	b.RunParallel(func(pb *testing.PB) {
		// use 1 thread as writer
		if atomic.CompareAndSwapUintptr(&writer, 0, 1) {
			for pb.Next() {
				for i := uintptr(0); i < benchmarkItemCount; i++ {
					m.Store(i, i)
				}
			}
		} else {
			for pb.Next() {
				for i := uintptr(0); i < benchmarkItemCount; i++ {
					j, _ := m.Load(i)
					if j != i {
						b.Fail()
					}
				}
			}
		}
	})
}

// cornelk/hashmap
func BenchmarkReadHashMapWithWritesUint(b *testing.B) {
	m := setupHashMap(b)
	var writer uintptr
	b.ResetTimer()

	b.RunParallel(func(pb *testing.PB) {
		// use 1 thread as writer
		if atomic.CompareAndSwapUintptr(&writer, 0, 1) {
			for pb.Next() {
				for i := uintptr(0); i < benchmarkItemCount; i++ {
					m.Set(i, i)
				}
			}
		} else {
			for pb.Next() {
				for i := uintptr(0); i < benchmarkItemCount; i++ {
					j, _ := m.Get(i)
					if j != i {
						b.Fail()
					}
				}
			}
		}
	})
}
