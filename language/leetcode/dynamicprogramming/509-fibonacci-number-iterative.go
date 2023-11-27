//go:build ignore

//The Fibonacci numbers, commonly denoted F(n) form a sequence, called the
//Fibonacci sequence, such that each number is the sum of the two preceding ones,
//starting from 0 and 1. That is,
//
//
//F(0) = 0, F(1) = 1
//F(n) = F(n - 1) + F(n - 2), for n > 1.
//
//
// Given n, calculate F(n).
//
//
// Example 1:
//
//
//Input: n = 2
//Output: 1
//Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.
//
//
// Example 2:
//
//
//Input: n = 3
//Output: 2
//Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.
//
//
// Example 3:
//
//
//Input: n = 4
//Output: 3
//Explanation: F(4) = F(3) + F(2) = 2 + 1 = 3.
//
//
//
// Constraints:
//
//
// 0 <= n <= 30
//
//
// Related Topics Math Dynamic Programming Recursion Memoization
// 👍 7711 👎 336

// 2023-11-26 16:58:42

package solution

//leetcode submit region begin(Prohibit modification and deletion)

// Reduce memory usage:
// meaningful history depth == 2

func fib2(n int) int {
	if n == 0 {
		return 0
	} else if n == 1 {
		return 1
	}
	serialNumber := 2
	past1, past2 := 1, 0

	var now int
	for serialNumber <= n {
		now = past1 + past2

		// prepare for the next round
		past2 = past1
		past1 = now
		serialNumber++
	}
	return now
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:1 ms, faster than 87.11% of Go online submissions.
// Memory Usage:1.9 MB, less than 21.44% of Go online submissions.
//
// Interesting:
// Iteration makes program `faster` rather than `more resource efficient`
// So, an ordinary go program's memory overhead is about 1 MB?
// Or the memory we use never be recycled?
