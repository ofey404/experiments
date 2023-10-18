package main

import "fmt"

func main() {
	m := make(map[string]int)
	fmt.Printf("m[unset_key] = %d\n", m["unset_key"]) // 0
}
