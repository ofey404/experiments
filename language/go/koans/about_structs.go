package go_koans

import "reflect"

func aboutStructs() {
	var bob struct {
		name string
		age  int
	}
	bob.name = "bob"
	bob.age = 30

	assert(bob.name == "bob") // structs are collections of named variables
	assert(bob.age == 30)     // each field has both setter and getter behavior

	type person struct {
		name string
		age  int
	}

	var john person
	john.name = "bob"
	john.age = 30

	// ofey404: compare by value
	assert(bob == john) // assuredly, bob is certainly not john.. yet

	type InnerStruct struct {
		Value int
	}

	type ComplexStruct struct {
		Field1 *int
		Field2 map[string]string
		Field3 InnerStruct
	}
	// Create two instances of ComplexStruct
	fieldValue1 := 42
	fieldValue2 := 42
	struct1 := ComplexStruct{
		Field1: &fieldValue1,
		Field2: map[string]string{"a": "apple", "b": "banana"},
		Field3: InnerStruct{Value: 10},
	}
	struct2 := ComplexStruct{
		Field1: &fieldValue2,
		Field2: map[string]string{"a": "apple", "b": "banana"},
		Field3: InnerStruct{Value: 10},
	}

	// struct containing map[string]string cannot be directly compared
	// assert(struct1 == struct2) would fail to compile

	assert(reflect.DeepEqual(struct1, struct2)) // but we can compare by value
}
