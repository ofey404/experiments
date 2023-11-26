//Implement a first in first out (FIFO) queue using only two stacks. The
//implemented queue should support all the functions of a normal queue (push, peek, pop,
//and empty).
//
// Implement the MyQueue class:
//
//
// void push(int x) Pushes element x to the back of the queue.
// int pop() Removes the element from the front of the queue and returns it.
// int peek() Returns the element at the front of the queue.
// boolean empty() Returns true if the queue is empty, false otherwise.
//
//
// Notes:
//
//
// You must use only standard operations of a stack, which means only push to
//top, peek/pop from top, size, and is empty operations are valid.
// Depending on your language, the stack may not be supported natively. You may
//simulate a stack using a list or deque (double-ended queue) as long as you use
//only a stack's standard operations.
//
//
//
// Example 1:
//
//
//Input
//["MyQueue", "push", "push", "peek", "pop", "empty"]
//[[], [1], [2], [], [], []]
//Output
//[null, null, null, 1, 1, false]
//
//Explanation
//MyQueue myQueue = new MyQueue();
//myQueue.push(1); // queue is: [1]
//myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
//myQueue.peek(); // return 1
//myQueue.pop(); // return 1, queue is [2]
//myQueue.empty(); // return false
//
//
//
// Constraints:
//
//
// 1 <= x <= 9
// At most 100 calls will be made to push, pop, peek, and empty.
// All the calls to pop and peek are valid.
//
//
//
// Follow-up: Can you implement the queue such that each operation is amortized
//O(1) time complexity? In other words, performing n operations will take overall
//O(n) time even if one of those operations may take longer.
//
// Related Topics Stack Design Queue
// 👍 6834 👎 389

// 2023-11-26 14:27:59

package solution

//leetcode submit region begin(Prohibit modification and deletion)

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

type MyQueue struct {
	iStack Stack
	oStack Stack
}

func Constructor() MyQueue {
	return MyQueue{}
}

func (this *MyQueue) Push(x int) {
	this.iStack.Push(x)
}

func (this *MyQueue) Pop() int {
	val, empty := this.oStack.Pop()
	if !empty {
		return val
	}

	// oStack empty, dump iStack into oStack
	for !this.iStack.Empty() {
		val, _ := this.iStack.Pop()
		this.oStack.Push(val)
	}
	val, empty = this.oStack.Pop()
	if empty {
		panic("should not pop an empty queue")
	}
	return val
}

func (this *MyQueue) Peek() int {
	val, empty := this.oStack.Peek()
	if !empty {
		return val
	}
	val, empty = this.iStack.PeekBottom()
	if empty {
		panic("should not peek an empty queue")
	}
	return val
}

func (this *MyQueue) Empty() bool {
	return this.iStack.Empty() && this.oStack.Empty()
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Push(x);
 * param_2 := obj.Pop();
 * param_3 := obj.Peek();
 * param_4 := obj.Empty();
 */
//leetcode submit region end(Prohibit modification and deletion)

// Runtime:1 ms, faster than 81.43% of Go online submissions.
// Memory Usage:2 MB, less than 98.37% of Go online submissions.
