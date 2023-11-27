//go:build ignore

//Find all valid combinations of k numbers that sum up to n such that the
//following conditions are true:
//
//
// Only numbers 1 through 9 are used.
// Each number is used at most once.
//
//
// Return a list of all possible valid combinations. The list must not contain
//the same combination twice, and the combinations may be returned in any order.
//
//
// Example 1:
//
//
//Input: k = 3, n = 7
//Output: [[1,2,4]]
//Explanation:
//1 + 2 + 4 = 7
//There are no other valid combinations.
//
// Example 2:
//
//
//Input: k = 3, n = 9
//Output: [[1,2,6],[1,3,5],[2,3,4]]
//Explanation:
//1 + 2 + 6 = 9
//1 + 3 + 5 = 9
//2 + 3 + 4 = 9
//There are no other valid combinations.
//
//
// Example 3:
//
//
//Input: k = 4, n = 1
//Output: []
//Explanation: There are no valid combinations.
//Using 4 different numbers in the range [1,9], the smallest sum we can get is 1
//+2+3+4 = 10 and since 10 > 1, there are no valid combination.
//
//
//
// Constraints:
//
//
// 2 <= k <= 9
// 1 <= n <= 60
//
//
// Related Topics Array Backtracking
// 👍 5622 👎 102

// 2023-11-27 22:32:49

package backtrack

// leetcode submit region begin(Prohibit modification and deletion)
func combinationSum3(k int, n int) [][]int {
	candidate := []int{
		1, 2, 3, 4, 5, 6, 7, 8, 9,
	}
	var history []int
	var ans [][]int

	dfs(candidate, k, n, &history, &ans)

	return ans
}

func dfs(candidate []int, k int, n int, history *[]int, ans *[][]int) {
	s := sum(*history...)
	if len(*history) == k && s == n {
		c := make([]int, len(*history))
		copy(c, *history)
		*ans = append(*ans, c)
		return
	} else if len(*history) >= k || s > n {
		return
	}

	// len(*history) < k && s < n
	// we still have chance
	for i, c := range candidate {
		*history = append(*history, c)

		dfs(candidate[i+1:], k, n, history, ans)
		*history = (*history)[:len(*history)-1]
	}
}

func sum(in ...int) int {
	ans := 0
	for _, i := range in {
		ans = ans + i
	}
	return ans
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:1 ms, faster than 82.14% of Go online submissions.
// Memory Usage:1.9 MB, less than 77.14% of Go online submissions.
