package main

import "fmt"

type MyType struct {
	MySpec
	MyStatus
}

type MySpec struct {
	field1 string
}

type MyStatus struct {
	field2 string
}

func main() {
	myType := MyType{
		MySpec: MySpec{
			field1: "value1",
		},
		MyStatus: MyStatus{
			field2: "value2",
		},
	}

	fmt.Printf("myType: %+v\n", myType)
}
