package leak

import (
	"math/rand"
	"time"
)

func search() []string {
	result := make(chan []string)
	for i := 0; i < 3; i++ {
		go func() {
			result <- get()
		}()
	}

	return <-result
}

func get() []string {
	time.Sleep(time.Duration(rand.Intn(10) * int(time.Millisecond))) // #nosec G404
	return []string{"hello", "how"}
}
