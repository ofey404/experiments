//go:build ignore

//Given an array of distinct integers candidates and a target integer target,
//return a list of all unique combinations of candidates where the chosen numbers
//sum to target. You may return the combinations in any order.
//
// The same number may be chosen from candidates an unlimited number of times.
//Two combinations are unique if the frequency of at least one of the chosen
//numbers is different.
//
// The test cases are generated such that the number of unique combinations
//that sum up to target is less than 150 combinations for the given input.
//
//
// Example 1:
//
//
//Input: candidates = [2,3,6,7], target = 7
//Output: [[2,2,3],[7]]
//Explanation:
//2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple
//times.
//7 is a candidate, and 7 = 7.
//These are the only two combinations.
//
//
// Example 2:
//
//
//Input: candidates = [2,3,5], target = 8
//Output: [[2,2,2,2],[2,3,3],[3,5]]
//
//
// Example 3:
//
//
//Input: candidates = [2], target = 1
//Output: []
//
//
//
// Constraints:
//
//
// 1 <= candidates.length <= 30
// 2 <= candidates[i] <= 40
// All elements of candidates are distinct.
// 1 <= target <= 40
//
//
// Related Topics Array Backtracking
// 👍 17889 👎 366

// 2023-11-27 21:33:12

package solution

// leetcode submit region begin(Prohibit modification and deletion)
func combinationSum(candidates []int, target int) [][]int {
	var history []int
	var ans [][]int

	dfs(candidates, target, &history, &ans)

	return ans
}

func dfs(candidates []int, target int, history *[]int, ans *[][]int) {
	s := sum(*history...)
	if s > target {
		return
	} else if s == target {
		historyCopy := make([]int, len(*history))
		copy(historyCopy, *history)
		*ans = append(*ans, historyCopy)
		return
	}

	// recursion
	for _, c := range candidates {
		if len(*history) != 0 && (*history)[len(*history)-1] > c {
			// simply skip. There is room for optimization here, but it would
			// complicate the code. so I won't do it.
			continue
		}
		*history = append(*history, c)
		dfs(candidates, target, history, ans)
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

// Runtime:4 ms, faster than 40.32% of Go online submissions.
// Memory Usage:2.8 MB, less than 99.15% of Go online submissions.
