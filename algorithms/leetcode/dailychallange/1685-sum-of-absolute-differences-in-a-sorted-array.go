//go:build ignore

//You are given an integer array nums sorted in non-decreasing order.
//
// Build and return an integer array result with the same length as nums such
//that result[i] is equal to the summation of absolute differences between nums[i]
//and all the other elements in the array.
//
// In other words, result[i] is equal to sum(|nums[i]-nums[j]|) where 0 <= j <
//nums.length and j != i (0-indexed).
//
//
// Example 1:
//
//
//Input: nums = [2,3,5]
//Output: [4,3,5]
//Explanation: Assuming the arrays are 0-indexed, then
//result[0] = |2-2| + |2-3| + |2-5| = 0 + 1 + 3 = 4,
//result[1] = |3-2| + |3-3| + |3-5| = 1 + 0 + 2 = 3,
//result[2] = |5-2| + |5-3| + |5-5| = 3 + 2 + 0 = 5.
//
//
// Example 2:
//
//
//Input: nums = [1,4,6,8,10]
//Output: [24,15,13,15,21]
//
//
//
// Constraints:
//
//
// 2 <= nums.length <= 10⁵
// 1 <= nums[i] <= nums[i + 1] <= 10⁴
//
//
// Related Topics Array Math Prefix Sum
// 👍 1727 👎 54

// 2023-11-25 23:46:24

package solution

//leetcode submit region begin(Prohibit modification and deletion)

func _reverse(nums []int) {
	left, right := 0, len(nums)-1
	for left < right {
		nums[left], nums[right] = nums[right], nums[left]
		left++
		right--
	}
}

func _getAbs(nums, ans []int, i int) {
	if i == 0 {
		ans[i] = 0
		return
	}
	_getAbs(nums, ans, i-1)
	
	_absDiff := func(l, r int) int{
		if l > r {
			return l - r
		} else {
			return r - l
		}
	}
	ans[i] = ans[i-1] + i*_absDiff(nums[i],nums[i-1])
}

func getSumAbsoluteDifferences(nums []int) []int {
	var (
		abs         = make([]int, len(nums))
		absReversed         = make([]int, len(nums))
	)

	_getAbs(nums, abs, len(nums)-1)
	_reverse(nums)
	_getAbs(nums, absReversed, len(nums)-1)
	_reverse(absReversed)

	ans := make([]int, len(nums))
	for i := range abs {
		ans[i] = abs[i] + absReversed[i]
	}
	return ans
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:143 ms, faster than 6.90% of Go online submissions.
// Memory Usage:21.1 MB, less than 6.90% of Go online submissions.
//
// A slow solution...
