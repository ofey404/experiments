//Given an integer array nums and an integer k, return the k most frequent
//elements. You may return the answer in any order.
//
//
// Example 1:
// Input: nums = [1,1,1,2,2,3], k = 2
//Output: [1,2]
//
// Example 2:
// Input: nums = [1], k = 1
//Output: [1]
//
//
// Constraints:
//
//
// 1 <= nums.length <= 10⁵
// -10⁴ <= nums[i] <= 10⁴
// k is in the range [1, the number of unique elements in the array].
// It is guaranteed that the answer is unique.
//
//
//
// Follow up: Your algorithm's time complexity must be better than O(n log n),
//where n is the array's size.
//
// Related Topics Array Hash Table Divide and Conquer Sorting Heap (Priority
//Queue) Bucket Sort Counting Quickselect
// 👍 16339 👎 596

// 2023-11-26 11:47:09

package solution

// leetcode submit region begin(Prohibit modification and deletion)
func topKFrequent(nums []int, k int) []int {
	freqMap := make(map[int]int)

	for _, n := range nums {
		freqMap[n]++
	}

	minHeap := MaxHeap{less: func(l, r valFreqPair) bool {
		return l.freq > r.freq
	}}

	for val, freq := range freqMap {
		minHeap.Push(valFreqPair{
			val:  val,
			freq: freq,
		})

		for minHeap.Size() > k {
			minHeap.Pop()
		}
	}

	var ans []int
	for minHeap.Size() > 0 {
		pair, _ := minHeap.Pop()
		ans = append(ans, pair.val)
	}
	return ans
}

type valFreqPair struct {
	val  int
	freq int
}

// ##################################################################
// utils.MaxHeap
// ##################################################################

type MaxHeap struct {
	data []valFreqPair
	less func(l, r valFreqPair) bool
}

// Push => O(heap height) => O(log(heap size))
func (h *MaxHeap) Push(val valFreqPair) {
	h.data = append(h.data, val)

	// float the val from bottom
	this := len(h.data) - 1
	for h.less(h.data[parent(this)], h.data[this]) {
		h.swap(this, parent(this))
		this = parent(this)
	}
}

func (h *MaxHeap) Pop() (val valFreqPair, empty bool) {
	if h.Size() == 0 {
		return valFreqPair{}, true
	}
	val = h.data[0]

	// fill the hole with last element
	h.data[0] = h.data[len(h.data)-1]
	h.data = h.data[:len(h.data)-1]

	if h.Size() != 0 {
		// skip reconcile if length == 0
		h.reconcile(0)
	}
	return val, false
}

func (h *MaxHeap) Top() (val valFreqPair, empty bool) {
	if len(h.data) == 0 {
		return valFreqPair{}, true
	}
	return h.data[0], false
}

func (h *MaxHeap) Size() int {
	return len(h.data)
}

func (h *MaxHeap) swap(i, j int) {
	h.data[i], h.data[j] = h.data[j], h.data[i]
}

func (h *MaxHeap) reconcile(i int) {
	if i > len(h.data)-1 {
		panic("reconcile target out of heap")
	}
	left, right := lChild(i), rChild(i)

	maxIndex := i
	if left < len(h.data) && h.less(h.data[maxIndex], h.data[left]) {
		maxIndex = left
	}
	if right < len(h.data) && h.less(h.data[maxIndex], h.data[right]) {
		maxIndex = right
	}

	if maxIndex != i {
		h.swap(maxIndex, i)

		// reconcile subtree
		h.reconcile(maxIndex)
	}
}

// ##################################################################
// Helpers
// ##################################################################

func parent(i int) int {
	// parent(0) => 0
	return (i - 1) / 2
}

func lChild(i int) int {
	return 2*i + 1
}

func rChild(i int) int {
	return 2*i + 2
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:9 ms, faster than 85.36% of Go online submissions.
// Memory Usage:6.1 MB, less than 34.81% of Go online submissions.
