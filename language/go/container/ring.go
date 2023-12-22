//go:build ignore

package main

import (
	"container/ring"
	"fmt"
	"time"
)

func main() {
	coffee := []string{"kenya", "guatemala", "ethiopia"}

	// create a ring and populate it with some values
	r := ring.New(len(coffee))
	for i := 0; i < r.Len(); i++ {
		r.Value = coffee[i]
		r = r.Next()
	}

	fmt.Println("# print all values of the ring, easy done with ring.Do()")
	r.Do(func(x interface{}) {
		fmt.Println(x)
	})

	counter := 0
	fmt.Println("# .. or each one by one. print first 5 values")
	for _ = range time.Tick(time.Second * 1) {
		r = r.Next()
		fmt.Println(r.Value)
		counter += 1
		if counter == 5 {
			return
		}
	}
}
