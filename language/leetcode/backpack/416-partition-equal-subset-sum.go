//go:build ignore

//Given an integer array nums, return true if you can partition the array into
//two subsets such that the sum of the elements in both subsets is equal or false
//otherwise.
//
//
// Example 1:
//
//
//Input: nums = [1,5,11,5]
//Output: true
//Explanation: The array can be partitioned as [1, 5, 5] and [11].
//
//
// Example 2:
//
//
//Input: nums = [1,2,3,5]
//Output: false
//Explanation: The array cannot be partitioned into equal sum subsets.
//
//
//
// Constraints:
//
//
// 1 <= nums.length <= 200
// 1 <= nums[i] <= 100
//
//
// Related Topics Array Dynamic Programming
// 👍 11742 👎 221

// 2023-12-02 20:35:16

package backpack

//leetcode submit region begin(Prohibit modification and deletion)

func canPartition(nums []int) bool {
	s := sum(nums)
	target := s / 2
	if 2*target != s {
		return false // short circuit
	}
	canReach := make([]bool, target+1)
	canReach[0] = true
	for _, n := range nums {
		for i := target; i >= n; i-- {
			if canReach[i-n] {
				canReach[i] = true
			}
		}
		// each inner loop above has only 1 chance to update canReach[target]
		// so we can check only once outside the loop.
		if canReach[target] == true {
			return true
		}
	}
	return false
}

func sum(nums []int) int {
	ans := 0
	for _, n := range nums {
		ans = ans + n
	}
	return ans
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:10 ms, faster than 91.58% of Go online submissions.
// Memory Usage:2.5 MB, less than 97.64% of Go online submissions.
