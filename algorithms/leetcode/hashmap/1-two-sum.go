//go:build ignore

//Given an array of integers nums and an integer target, return indices of the
//two numbers such that they add up to target.
//
// You may assume that each input would have exactly one solution, and you may
//not use the same element twice.
//
// You can return the answer in any order.
//
//
// Example 1:
//
//
//Input: nums = [2,7,11,15], target = 9
//Output: [0,1]
//Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].
//
//
// Example 2:
//
//
//Input: nums = [3,2,4], target = 6
//Output: [1,2]
//
//
// Example 3:
//
//
//Input: nums = [3,3], target = 6
//Output: [0,1]
//
//
//
// Constraints:
//
//
// 2 <= nums.length <= 10⁴
// -10⁹ <= nums[i] <= 10⁹
// -10⁹ <= target <= 10⁹
// Only one valid answer exists.
//
//
//
//Follow-up: Can you come up with an algorithm that is less than
//O(n²)
// time complexity?
//
// Related Topics Array Hash Table
// 👍 53234 👎 1759

// 2023-11-25 22:27:47

package solution

//leetcode submit region begin(Prohibit modification and deletion)
import (
	"sort"
)

//						right
// 0 --------------------------------------
//
//			sum
//
// left

type pair struct {
	val           int
	originalIndex int
}

// O(nlogn) with a sort. Not good.
func twoSum(nums []int, target int) []int {
	var pairs []pair
	for i, n := range nums {
		pairs = append(pairs, pair{val: n, originalIndex: i})
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i].val < pairs[j].val
	}) // ascending

	left, right := 0, len(nums)-1
	for left < right {
		sum := pairs[left].val + pairs[right].val
		if sum < target {
			left++
		} else if sum > target {
			right--
		} else {
			return []int{pairs[left].originalIndex, pairs[right].originalIndex}
		}
	}
	panic("assume that each input would have exactly one solution")
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:8 ms, faster than 43.17% of Go online submissions.
// Memory Usage:5 MB, less than 9.69% of Go online submissions.
//
// Hashmap solution is in language/leetcode/hashmap/1-two-sum-hashmap.go,
