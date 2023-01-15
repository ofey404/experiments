package concurrency

import "math/rand"

func repeatFn(done <-chan any, fn func() any) <-chan any {
	valueStream := make(chan any)
	go func() {
		defer close(valueStream)
		for {
			select {
			case <-done:
				return
			case valueStream <- fn():
			}
		}
	}()
	return valueStream
}

func repeat(done <-chan any, values ...any) <-chan any { // nolint
	valueStream := make(chan any)
	go func() {
		defer close(valueStream)
		for {
			for _, v := range values {
				select {
				case <-done:
					return
				case valueStream <- v:
				}
			}
		}
	}()
	return valueStream
}

func take(done <-chan any, valueStream <-chan any, n int) <-chan any {
	takeStream := make(chan any)
	go func() {
		defer close(takeStream)
		for i := 0; i < n; i++ {
			select {
			case <-done:
				return
			case takeStream <- <-valueStream:
			}
		}
	}()
	return takeStream
}

func MultiLevelPipeline(done <-chan any, level int, takeCount int) <-chan any {
	stream := repeatFn(done, func() any { return rand.Int() }) // #nosec
	for n := 0; n < level; n++ {
		stream = take(done, stream, takeCount)
	}
	return stream
}
