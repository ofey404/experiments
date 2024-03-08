//go:build ignore

//Assume you are an awesome parent and want to give your children some cookies.
//But, you should give each child at most one cookie.
//
// Each child i has a greed factor g[i], which is the minimum size of a cookie
//that the child will be content with; and each cookie j has a size s[j]. If s[j] >
//= g[i], we can assign the cookie j to the child i, and the child i will be
//content. Your goal is to maximize the number of your content children and output the
//maximum number.
//
//
// Example 1:
//
//
//Input: g = [1,2,3], s = [1,1]
//Output: 1
//Explanation: You have 3 children and 2 cookies. The greed factors of 3
//children are 1, 2, 3.
//And even though you have 2 cookies, since their size is both 1, you could
//only make the child whose greed factor is 1 content.
//You need to output 1.
//
//
// Example 2:
//
//
//Input: g = [1,2], s = [1,2,3]
//Output: 2
//Explanation: You have 2 children and 3 cookies. The greed factors of 2
//children are 1, 2.
//You have 3 cookies and their sizes are big enough to gratify all of the
//children,
//You need to output 2.
//
//
//
// Constraints:
//
//
// 1 <= g.length <= 3 * 10⁴
// 0 <= s.length <= 3 * 10⁴
// 1 <= g[i], s[j] <= 2³¹ - 1
//
//
// Related Topics Array Two Pointers Greedy Sorting
// 👍 2747 👎 251

// 2023-11-26 16:41:32

package solution

import (
	"sort"
)

// There is a recursion.
//
// Assuming the cookies enter the system in ascending order, then full(i+1) =
// full(i) + if(cookie i can satisfy any remaining child).
//
// Since cookie i is larger than any previous cookie, we only need to see if
// cookie i can satisfy the child with the smallest appetite among the hungry.
//
// If not, this cookie will be useless later and can be discarded, full(i+1)
// doesn't change.
//
// So, full(i+1) can be derived only from full(i) and the current state, without
// the need for historical information.

// leetcode submit region begin(Prohibit modification and deletion)
func findContentChildren(greedyFactor []int, size []int) int {
	sort.Ints(greedyFactor)
	sort.Ints(size)

	childWithSmallestAppetite, cookie := 0, 0
	for cookie < len(size) && childWithSmallestAppetite < len(greedyFactor) {
		if greedyFactor[childWithSmallestAppetite] <= size[cookie] {
			// we find a match
			cookie++
			childWithSmallestAppetite++
		} else {
			cookie++
		}
	}

	return childWithSmallestAppetite
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:23 ms, faster than 85.57% of Go online submissions.
// Memory Usage:6 MB, less than 79.38% of Go online submissions.
