//Write a function that reverses a string. The input string is given as an
//array of characters s.
//
// You must do this by modifying the input array in-place with O(1) extra
//memory.
//
//
// Example 1:
// Input: s = ["h","e","l","l","o"]
//Output: ["o","l","l","e","h"]
//
// Example 2:
// Input: s = ["H","a","n","n","a","h"]
//Output: ["h","a","n","n","a","H"]
//
//
// Constraints:
//
//
// 1 <= s.length <= 10⁵
// s[i] is a printable ascii character.
//
//
// Related Topics Two Pointers String
// 👍 8044 👎 1137

// 2023-11-25 22:55:55

package solution

// leetcode submit region begin(Prohibit modification and deletion)
func reverseString(s []byte) {
	left, right := 0, len(s)-1
	for left < right {
		s[left], s[right] = s[right], s[left]
		left++
		right--
	}
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:30 ms, faster than 51.48% of Go online submissions.
// Memory Usage:6.6 MB, less than 53.25% of Go online submissions.
//
// Performance just passable
