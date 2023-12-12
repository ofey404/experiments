package main

import "fmt"

// Container is a generic interface
type Container[T any] interface {
	Add(item T)
	Remove() T
	IsEmpty() bool
}

// Stack is a generic struct
type Stack[T any] struct {
	items []T
}

// Add Implementing the generic interface for Stack
func (s *Stack[T]) Add(item T) {
	s.items = append(s.items, item)
}

func (s *Stack[T]) Remove() T {
	if s.IsEmpty() {
		panic("Stack is empty")
	}
	length := len(s.items)
	item := s.items[length-1]
	s.items = s.items[:length-1]
	return item
}

func (s *Stack[T]) IsEmpty() bool {
	return len(s.items) == 0
}

func main() {
	fmt.Println("generic stack can compile")
	stack := Stack[int]{} // Creating a stack of type int
	stack.Add(1)
	stack.Add(2)
	stack.Add(3)
	fmt.Println(stack.Remove()) // Output: 3
}

// go run .
// generic stack can compile
// 3
