package go_koans

import "fmt"

func aboutArrays() {
	fruits := [4]string{"apple", "orange", "mango"}

	assert(fruits[0] == "apple")  // indexes begin at 0
	assert(fruits[1] == "orange") // one is indeed the loneliest number
	assert(fruits[2] == "mango")  // it takes two to ...tango?
	assert(fruits[3] == "")       // there is no spoon, only an empty value

	// ofey404: an array's length is part of its type, which is different from slice
	assert(len(fruits) == 4) // the length is what the length is
	assert(cap(fruits) == 4) // it can hold no more

	assert(fruits != [4]string{}) // comparing arrays is not like comparing apples and oranges

	tasty_fruits := fruits[1:3] // defining oneself as a variation of another
	// ofey404: %T means type
	assert(fmt.Sprintf("%T", tasty_fruits) == "[]string") //and get not a simple array as a result
	assert(tasty_fruits[0] == "orange")                   // slices of arrays share some data
	assert(tasty_fruits[1] == "mango")                    // albeit slightly askewed

	assert(len(tasty_fruits) == 2) // its length is manifest

	assert(cap(tasty_fruits) == 3) // but its capacity is surprising!
	// ofey404: WHY?????
	//
	// https://go.dev/tour/moretypes/11#:~:text=The%20capacity%20of%20a%20slice,provided%20it%20has%20sufficient%20capacity.
	// > The capacity of a slice is the number of elements in the underlying array,
	// > counting from the first element in the slice.

	// ofey404: change through the slice
	tasty_fruits[0] = "lemon" // are their shared roots truly identical?

	assert(fruits[0] == "apple") // has this element remained the same?
	assert(fruits[1] == "lemon") // how about the second?
	assert(fruits[2] == "mango") // surely one of these must have changed
	assert(fruits[3] == "")      // but who can know these things

	veggies := [...]string{"carrot", "pea"}

	assert(len(veggies) == 2) // array literals need not repeat an obvious length
}
