//go:build ignore

//Given two integers n and k, return all possible combinations of k numbers
//chosen from the range [1, n].
//
// You may return the answer in any order.
//
//
// Example 1:
//
//
//Input: n = 4, k = 2
//Output: [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
//Explanation: There are 4 choose 2 = 6 total combinations.
//Note that combinations are unordered, i.e., [1,2] and [2,1] are considered to
//be the same combination.
//
//
// Example 2:
//
//
//Input: n = 1, k = 1
//Output: [[1]]
//Explanation: There is 1 choose 1 = 1 total combination.
//
//
//
// Constraints:
//
//
// 1 <= n <= 20
// 1 <= k <= n
//
//
// Related Topics Backtracking
// 👍 7869 👎 206

// 2023-11-26 21:25:26

package solution

// backtrack: We need to persist the full history.
//            There is no DP (static history size)
//            or Greedy (No history size) solution.

//leetcode submit region begin(Prohibit modification and deletion)

//import "fmt"

func combine(n int, k int) [][]int {
	var history []int
	choose := 1
	var ans [][]int
	dfs(&history, choose, n, k, &ans)
	return ans
}

// About ans *[][]int in dfs():
//
// > Slices have all of the concurrent memory pitfalls of C++’s string_view, but
// > none of the protections of C++ move-only types.
// > https://www.dolthub.com/blog/2023-10-20-golang-pitfalls-3/
//
// My rule of thumb, when passing slices around function:
//
// 1. If you have to use it like a C++ string pointer,
//    (like the quick and dirty method in competitive programming),
//    use slice pointer.
//
// 2. In production, use a struct field as a unique slice holder.
//
// 3. Be extremely cautious when returning a slice.
//    If not sure, refer to the blogpost above.

func dfs(history *[]int, choose, n, k int, ans *[][]int) {
	//fmt.Printf("dfs, history %+v, choose %d, ans %+v\n", history, choose, ans)
	if len(*history) == k {
		//fmt.Printf("append history %+v to ans %+v\n", history, ans)
		historyCopy := make([]int, len(*history))
		copy(historyCopy, *history)
		*ans = append(*ans, historyCopy)
		return
	}
	for i := choose; i <= n; i++ {
		*history = append(*history, i)

		dfs(history, i+1, n, k, ans)

		// dfs end
		*history = (*history)[:len(*history)-1]
	}
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:137 ms, faster than 74.20% of Go online submissions.
// Memory Usage:55.6 MB, less than 65.51% of Go online submissions.
//
// At the very least, the memory consumption and speed are somewhat satisfactory.
