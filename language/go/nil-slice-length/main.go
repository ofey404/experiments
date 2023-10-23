package main

import "fmt"

func main() {
	var nilSlice []string

	// len(nilSlice) = 0
	fmt.Printf("len(nilSlice) = %d\n", len(nilSlice))

	// it can be iterated
	for _, s := range nilSlice {
		fmt.Println(s)
	}
}
