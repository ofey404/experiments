package solution_utils

// ##################################################################
// utils.MaxHeap
// ##################################################################

type MaxHeap struct {
	data []int
	less func(l, r int) bool
}

// Push => O(heap height) => O(log(heap size))
func (h *MaxHeap) Push(val int) {
	h.data = append(h.data, val)

	// float the val from bottom
	this := len(h.data) - 1
	for h.less(h.data[parent(this)], h.data[this]) {
		h.swap(this, parent(this))
		this = parent(this)
	}
}

func (h *MaxHeap) Pop() (val int, empty bool) {
	if h.Size() == 0 {
		return 0, true
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

func (h *MaxHeap) Top() (val int, empty bool) {
	if len(h.data) == 0 {
		return 0, true
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
