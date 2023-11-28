package main

import (
	"fmt"
	"testing"
)

func TestMain(t *testing.T) {
	var SubscriberCount map[string]int
	SubscriberCount["publisher_name"]++
	fmt.Printf("%+v\n", SubscriberCount)
	// fmt.Printf("%+v\n", SubscriberCount["publisher_name"])
}

// panic: assignment to entry in nil map [recovered]
//         panic: assignment to entry in nil map

func TestEmptyStructValue(t *testing.T) {
	var counter = make(map[string]struct{})
	counter["my_key"] = struct{}{}
	for k, v := range counter {
		fmt.Printf("k: %s, v: %+v\n", k, v)
	}
}

// === RUN   TestEmptyStructValue
// k: my_key, v: {}
// --- PASS: TestEmptyStructValue (0.00s)
// PASS
