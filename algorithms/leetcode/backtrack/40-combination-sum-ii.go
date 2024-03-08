//go:build ignore

//Given a collection of candidate numbers (candidates) and a target number (
//target), find all unique combinations in candidates where the candidate numbers sum
//to target.
//
// Each number in candidates may only be used once in the combination.
//
// Note: The solution set must not contain duplicate combinations.
//
//
// Example 1:
//
//
//Input: candidates = [10,1,2,7,6,1,5], target = 8
//Output:
//[
//[1,1,6],
//[1,2,5],
//[1,7],
//[2,6]
//]
//
//
// Example 2:
//
//
//Input: candidates = [2,5,2,1,2], target = 5
//Output:
//[
//[1,2,2],
//[5]
//]
//
//
//
// Constraints:
//
//
// 1 <= candidates.length <= 100
// 1 <= candidates[i] <= 50
// 1 <= target <= 30
//
//
// Related Topics Array Backtracking
// 👍 9853 👎 259

// 2023-11-27 21:56:18

package backtrack

import (
	//"fmt"
	"sort"
)

//leetcode submit region begin(Prohibit modification and deletion)

func combinationSum2(candidates []int, target int) [][]int {
	var history []int
	var ans [][]int

	sort.Ints(candidates) // ascending

	dfs(candidates, target, &history, &ans)

	return ans
}

func dfs(candidates []int, target int, history *[]int, ans *[][]int) {
	//fmt.Printf("candidates %+v, history %+v, ans %+v\n", candidates, *history, *ans)
	s := sum(*history...)
	if s == target {
		h := make([]int, len(*history))
		copy(h, *history)
		*ans = append(*ans, h)
		return
	} else if s > target {
		return
	}

	for _, i := range indexOfEveryFirstUniqueNumber(candidates) {
		*history = append(*history, candidates[i])

		dfs(candidates[i+1:], target, history, ans)

		*history = (*history)[0 : len(*history)-1]
	}
}

func sum(in ...int) int {
	ans := 0
	for _, i := range in {
		ans = ans + i
	}
	return ans
}

func indexOfEveryFirstUniqueNumber(candidates []int) []int {
	meet := -1
	var ans []int
	for i, val := range candidates {
		if val != meet {
			ans = append(ans, i)
		}
		meet = val
	}
	//fmt.Printf("indexOfEveryFirstUniqueNumber = %+v\n", ans)
	return ans
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:3 ms, faster than 70.99% of Go online submissions.
// Memory Usage:5.1 MB, less than 17.75% of Go online submissions.
