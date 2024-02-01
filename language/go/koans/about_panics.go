package go_koans

func divideFourBy(i int) int {
	return 4 / i
}

const (
	__divisor__ = 0
)

func aboutPanics() {
	defer func() {
		if r := recover(); r != nil {
			// sooth the panic
		}
	}()

	divideFourBy(__divisor__)

	assert(__this_line_wont_be_executed__)
}
