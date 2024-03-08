//go:build ignore

package solution_utils

import (
	"fmt"
	"testing"
)

// Original array:  [1 3 5 7 9 2 4 6 8 10]
// Max Heap:  [10 9 4 7 8 2 3 1 6 5]
// Pop:  10
// Heap after pop:  [9 8 4 7 5 2 3 1 6]
// Heap after push 11:  [11 9 4 7 8 2 3 1 6 5]
// Heap content in pop order:  [11 9 8 7 6 5 4 3 2 1 0]

func TestHeap(t *testing.T) {
	arr := []int{1, 3, 5, 7, 9, 2, 4, 6, 8, 10}
	fmt.Println("Original array: ", arr)
	heap := MaxHeap{
		less: func(l, r int) bool {
			return l < r
		},
	}
	for _, i := range arr {
		heap.Push(i)
	}
	fmt.Println("Max MaxHeap: ", heap.data)
	val, _ := heap.Pop()
	fmt.Println("Pop: ", val)
	fmt.Println("MaxHeap after pop: ", heap.data)

	heap.Push(11)
	fmt.Println("MaxHeap after push 11: ", heap.data)

	empty := false
	var popOrder []int
	for !empty {
		val, empty = heap.Pop()
		popOrder = append(popOrder, val)
	}
	fmt.Println("MaxHeap content in pop order: ", popOrder)
}
