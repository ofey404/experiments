//Given two strings s and t, return true if t is an anagram of s, and false
//otherwise.
//
// An Anagram is a word or phrase formed by rearranging the letters of a
//different word or phrase, typically using all the original letters exactly once.
//
//
// Example 1:
// Input: s = "anagram", t = "nagaram"
//Output: true
//
// Example 2:
// Input: s = "rat", t = "car"
//Output: false
//
//
// Constraints:
//
//
// 1 <= s.length, t.length <= 5 * 10⁴
// s and t consist of lowercase English letters.
//
//
//
// Follow up: What if the inputs contain Unicode characters? How would you
//adapt your solution to such a case?
//
// Related Topics Hash Table String Sorting
// 👍 10991 👎 344

package solution

// leetcode submit region begin(Prohibit modification and deletion)
func isAnagram2(s string, t string) bool {
	// use array to reduce memory consumption
	getFreq := func(s string) []int32 {
		wordFreq := make([]int32, 26)
		for _, char := range s {
			index := char - 'a'
			wordFreq[index]++
		}
		return wordFreq
	}

	freqS := getFreq(s)
	freqT := getFreq(t)

	for index, countS := range freqS {
		countT := freqT[index]
		if countT != countS {
			return false
		}
	}
	return true
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:3 ms, faster than 76.55% of Go online submissions.
// Memory Usage:2.8 MB, less than 98.63% of Go online submissions.
//
// Beat 98% submissions.
