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

//import "fmt"

func canPartition(nums []int) bool {
	s := sum(nums)
	target := s / 2
	if 2*target != s {
		return false // short circuit
	}
	canReach := make(map[int]bool)
	canReach[0] = true
	for _, n := range nums {
		var _canReach []int
		for i, _ := range canReach {
			// copy the keys to avoid modify dict during the loop
			_canReach = append(_canReach, i)
		}

		for _, i := range _canReach {
			//fmt.Printf("target = %d, n = %d, i = %d, canReach = %+v\n", target, n, i, canReach)
			if i+n > target {
				continue
			} else if i+n == target {
				return true
			}
			//fmt.Printf("i+n = %d, canReach[i+n] = true\n", i+n)
			canReach[i+n] = true
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

// Runtime:124 ms, faster than 38.38% of Go online submissions.
// Memory Usage:13.9 MB, less than 20.54% of Go online submissions.
//
// 10 times slower than DP array method...
//
// Though using map eliminates unnecessary array value assignment,
// the map operation's intrinsic access overhead is too high.
