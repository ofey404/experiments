//Given a string array words, return an array of all characters that show up in
//all strings within the words (including duplicates). You may return the answer
//in any order.
//
//
// Example 1:
// Input: words = ["bella","label","roller"]
//Output: ["e","l","l"]
//
// Example 2:
// Input: words = ["cool","lock","cook"]
//Output: ["c","o"]
//
//
// Constraints:
//
//
// 1 <= words.length <= 100
// 1 <= words[i].length <= 100
// words[i] consists of lowercase English letters.
//
//
// Related Topics Array Hash Table String
// 👍 3384 👎 276

// 2023-11-25 22:04:14

package solution

// leetcode submit region begin(Prohibit modification and deletion)
func commonChars(words []string) []string {
	// max 100 words, it's acceptable to store all the frequencies.
	var wordCharFreqs [][]int32

	for _, word := range words {
		freq := make([]int32, 26)
		for _, char := range word {
			freq[char-'a']++
		}
		wordCharFreqs = append(wordCharFreqs, freq)
	}

	var ans []string
	// if word's char frequency has a minimum non-zero value,
	// it's appeared in all the words, with the minimum non-zero value times.
	for char := 0; char < 26; char++ {
		var min int32 = 2147483647 // max int32 value
		for _, freq := range wordCharFreqs {
			if freq[char] < min {
				min = freq[char]
			}
		}

		// find a fit
		if min != 0 {
			for i := 0; i < int(min); i++ {
				ans = append(ans, string('a'+char))
			}
		}
	}
	return ans
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:3 ms, faster than 83.67% of Go online submissions.
// Memory Usage:3.3 MB, less than 67.35% of Go online submissions.
