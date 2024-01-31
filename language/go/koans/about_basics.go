package go_koans

func aboutBasics() {
	assert(true)   // what is truth?
	assert(!false) // in it there is nothing false

	var i int = 1                                        // ofey404: the language allows for some implicit conversions if it can be done without loss of information
	assert(i == 1.0000000000000000000000000000000000000) // precision is in the eye of the beholder

	k := 1
	assert(k == 1.0000000000000000000000000000000000000) // short assignment can be used, as well

	assert(5%2 == 1)
	assert(5*2 == 10)
	assert(5^2 == 7) // ofey404: ^ is bitwise XOR, not exponentiation. 0b10 ^ 0b101 => 0b111 = 0d7

	var x int
	assert(x == 0) // zero values are valued in Go

	var f float32
	assert(f == 0.0) // for types of all types

	var s string
	assert(s == "") // both typical or atypical types

	var c struct {
		x int
		f float32
		s string
	}
	assert(c.x == 0)   // and types within composite types
	assert(c.f == 0.0) // which match the other types
	assert(c.s == "")  // in a typical way
}
