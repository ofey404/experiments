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

package solution

//leetcode submit region begin(Prohibit modification and deletion)

func canPartition(nums []int) bool {
	return canPartitionBruteForce(nums)
}

func canPartitionBruteForce(nums []int) bool {
	s := sum(nums)
	target := s / 2
	if 2*target != s {
		return false // short circuit
	}

	return _canPartitionBruteForce(nums, 0, target)
}

// _canPartitionBruteForce solves the backpack problem using a brute force backtrack method.
func _canPartitionBruteForce(nums []int, history, target int) bool {
	if history == target {
		return true
	} else if history > target {
		return false
	} else if len(nums) == 0 {
		return false
	}

	next := nums[0]
	// 2 cases: take or not take this element
	return _canPartitionBruteForce(nums[1:], history+next, target) ||
		_canPartitionBruteForce(nums[1:], history, target)
}

func sum(nums []int) int {
	ans := 0
	for _, n := range nums {
		ans = ans + n
	}
	return ans
}

//leetcode submit region end(Prohibit modification and deletion)

// Compile Error
// Time Limit Exceeded
