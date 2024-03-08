//go:build ignore

package solution_utils

// ###################################################################
// utils.Stack
// ###################################################################

type Stack struct {
	data []int
}

func (s *Stack) Push(x int) {
	s.data = append(s.data, x)
}

func (s *Stack) Peek() (val int, empty bool) {
	if s.Empty() {
		return 0, true
	}
	return s.data[len(s.data)-1], false
}

func (s *Stack) PeekBottom() (val int, empty bool) {
	if s.Empty() {
		return 0, true
	}
	return s.data[0], false
}

func (s *Stack) Pop() (val int, empty bool) {
	ans, empty := s.Peek()
	if empty {
		return 0, true
	}
	s.data = s.data[0 : len(s.data)-1]
	return ans, false
}

func (s *Stack) Empty() bool {
	return len(s.data) == 0
}
