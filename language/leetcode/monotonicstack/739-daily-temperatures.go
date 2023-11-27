//go:build ignore

//Given an array of integers temperatures represents the daily temperatures,
//return an array answer such that answer[i] is the number of days you have to wait
//after the iᵗʰ day to get a warmer temperature. If there is no future day for
//which this is possible, keep answer[i] == 0 instead.
//
//
// Example 1:
// Input: temperatures = [73,74,75,71,69,72,76,73]
//Output: [1,1,4,2,1,1,0,0]
//
// Example 2:
// Input: temperatures = [30,40,50,60]
//Output: [1,1,1,0]
//
// Example 3:
// Input: temperatures = [30,60,90]
//Output: [1,1,0]
//
//
// Constraints:
//
//
// 1 <= temperatures.length <= 10⁵
// 30 <= temperatures[i] <= 100
//
//
// Related Topics Array Stack Monotonic Stack
// 👍 11931 👎 261

// 2023-11-26 20:16:43

package monotonicstack

//leetcode submit region begin(Prohibit modification and deletion)

func dailyTemperatures(temperatures []int) []int {
	ans := make([]int, len(temperatures))

	// the tail element is the coldest data
	waitingForWarmer := Stack{}
	for date, temperature := range temperatures {
		//fmt.Printf("date %d start, temperature %d, stack content %+v\n", date, temperature, backtrackStack.data)
		coldest, empty := waitingForWarmer.Top()
		if empty || temperature <= coldest.temperature {
			waitingForWarmer.Push(Record{
				temperature: temperature,
				date:        date,
			})
			//fmt.Printf("date %d end, temperature %d, stack content %+v\n", date, temperature, backtrackStack.data)
			continue
		}

		// else, pop all viable records from the backtrack stack
		// then push this record.
		for !empty && temperature > coldest.temperature {
			coldest, _ = waitingForWarmer.Pop()
			ans[coldest.date] = date - coldest.date // calculate interval here

			// prepare for next loop
			coldest, empty = waitingForWarmer.Top()
		}
		waitingForWarmer.Push(Record{
			temperature: temperature,
			date:        date,
		})

		//fmt.Printf("date %d end, temperature %d, stack content %+v\n", date, temperature, backtrackStack.data)
	}

	return ans
}

type Record struct {
	temperature int
	date        int // index
}

type Stack struct {
	data []Record
}

func (s *Stack) Push(record Record) {
	s.data = append(s.data, record)
}

func (s *Stack) Pop() (record Record, empty bool) {
	if len(s.data) == 0 {
		return Record{}, true
	} else {
		record = s.data[len(s.data)-1]
		s.data = s.data[0 : len(s.data)-1]
		return record, false
	}
}

func (s *Stack) Top() (record Record, empty bool) {
	if len(s.data) == 0 {
		return Record{}, true
	} else {
		return s.data[len(s.data)-1], false
	}
}

func (s *Stack) Size() int {
	return len(s.data)
}

//leetcode submit region end(Prohibit modification and deletion)

// Runtime:159 ms, faster than 48.53% of Go online submissions.
// Memory Usage:13.2 MB, less than 22.50% of Go online submissions.
