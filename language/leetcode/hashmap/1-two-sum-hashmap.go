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

// O(n) with hashmap
func twoSum2(nums []int, target int) []int {
	valToIndex := make(map[int]int)
	for i, n := range nums {
		valToIndex[n] = i
	}

	for i, n := range nums {
		if j, ok := valToIndex[target-n]; ok {
			if i != j {
				return []int{i, j}
			}
		}
	}

	panic("assume that each input would have exactly one solution")
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:9 ms, faster than 40.22% of Go online submissions.
// Memory Usage:5.9 MB, less than 8.17% of Go online submissions.
