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

// Possible MLE:
//
// max recursion depth == 30
// stackDepth(n) = stackDepth(n-1) + stackDepth(n-2)
// stackDepth also grow as fib number
// fib(30) = 832040 ~= 0.8 MB

func fib(n int) int {
	if n == 0 {
		return 0
	} else if n == 1 {
		return 1
	}

	return fib(n-1) + fib(n-2)
}
//leetcode submit region end(Prohibit modification and deletion)

// Runtime:10 ms, faster than 27.44% of Go online submissions.
// Memory Usage:1.9 MB, less than 21.44% of Go online submissions.
