//go:build ignore

//Given a string s and an integer k, reverse the first k characters for every 2
//k characters counting from the start of the string.
//
// If there are fewer than k characters left, reverse all of them. If there are
//less than 2k but greater than or equal to k characters, then reverse the first
//k characters and leave the other as original.
//
//
// Example 1:
// Input: s = "abcdefg", k = 2
//Output: "bacdfeg"
//
// Example 2:
// Input: s = "abcd", k = 2
//Output: "bacd"
//
//
// Constraints:
//
//
// 1 <= s.length <= 10⁴
// s consists of only lowercase English letters.
// 1 <= k <= 10⁴
//
//
// Related Topics Two Pointers String
// 👍 1828 👎 3578

// 2023-11-25 22:58:22

package solution

// leetcode submit region begin(Prohibit modification and deletion)
func reverseStr(s string, k int) string {
	_reverseStr := func(s []byte) {
		left, right := 0, len(s)-1
		for left < right {
			s[left], s[right] = s[right], s[left]
			left++
			right--
		}
	}

	ss := []byte(s)
	for start:= 0; start < len(ss); start = start + 2*k {
		end := start + k // [start, end)
		if end > len(ss) {
			end = len(ss)
		}
		_reverseStr(ss[start:end])
	}
	return string(ss)
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:2 ms, faster than 67.18% of Go online submissions.
// Memory Usage:3.4 MB, less than 64.89% of Go online submissions.
