//go:build ignore

//You are given an array of integers stones where stones[i] is the weight of
//the iᵗʰ stone.
//
// We are playing a game with the stones. On each turn, we choose the heaviest
//two stones and smash them together. Suppose the heaviest two stones have weights
//x and y with x <= y. The result of this smash is:
//
//
// If x == y, both stones are destroyed, and
// If x != y, the stone of weight x is destroyed, and the stone of weight y has
//new weight y - x.
//
//
// At the end of the game, there is at most one stone left.
//
// Return the weight of the last remaining stone. If there are no stones left,
//return 0.
//
//
// Example 1:
//
//
//Input: stones = [2,7,4,1,8,1]
//Output: 1
//Explanation:
//We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
//we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
//we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
//we combine 1 and 1 to get 0 so the array converts to [1] then that's the
//value of the last stone.
//
//
// Example 2:
//
//
//Input: stones = [1]
//Output: 1
//
//
//
// Constraints:
//
//
// 1 <= stones.length <= 30
// 1 <= stones[i] <= 1000
//
//
// Related Topics Array Heap (Priority Queue)
// 👍 5740 👎 97

// 2023-12-02 22:23:04

package solution

// leetcode submit region begin(Prohibit modification and deletion)

func lastStoneWeight(stones []int) int {
	h := MaxHeap{}
	for _, s := range stones {
		h.Push(s)
	}

	for h.Size() >= 2 {
		stone1, _ := h.Pop()
		stone2, _ := h.Pop()

		if stone1 > stone2 {
			h.Push(stone1 - stone2)
		} else if stone1 < stone2 {
			h.Push(stone2 - stone1)
		}
	}
	if h.Size() == 0 {
		return 0
	}
	ans, _ := h.Pop()
	return ans
}

type MaxHeap struct {
	data []int
}

func (h *MaxHeap) Push(val int) {
	h.data = append(h.data, val)

	// rebalance from bottom up, maximum on the top
	head := len(h.data) - 1
	for h.data[head] > h.data[parent(head)] {
		h.data[head], h.data[parent(head)] = h.data[parent(head)], h.data[head]
		head = parent(head)
	}
}

func (h *MaxHeap) Pop() (val int, empty bool) {
	if len(h.data) == 0 {
		return 0, true
	}

	val = h.data[0]
	// fill the hole with final value
	h.data[0] = h.data[len(h.data)-1]
	h.data = h.data[:len(h.data)-1]

	h.rebalance(0)
	return val, false
}

func (h *MaxHeap) Size() int {
	return len(h.data)
}

func (h *MaxHeap) rebalance(i int) {
	indexMax := i

	// find the max among [parent, lChild, rChild]
	if lChild(i) < len(h.data) && h.data[lChild(i)] > h.data[indexMax] {
		indexMax = lChild(i)
	}
	if rChild(i) < len(h.data) && h.data[rChild(i)] > h.data[indexMax] {
		indexMax = rChild(i)
	}

	if indexMax != i {
		h.swap(i, indexMax)
		h.rebalance(indexMax)
	}
}

func (h *MaxHeap) swap(i, j int) {
	h.data[i], h.data[j] = h.data[j], h.data[i]
}

// eg: 1 2 => 0, 3 4 => 1
func parent(i int) int {
	return (i - 1) / 2
}

func lChild(i int) int {
	return 2*i + 1
}

func rChild(i int) int {
	return 2*i + 2
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:1 ms, faster than 81.16% of Go online submissions.
// Memory Usage:2.1 MB, less than 19.18% of Go online submissions.
