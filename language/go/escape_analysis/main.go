package main

import "fmt"

type Demo struct {
	name string
}

func pointerEscape(name string) *Demo {
	d := new(Demo) // local variable d escaped to heap
	d.name = name
	return d
}

func interfaceEscape(demo *Demo) {
	fmt.Println(demo.name)
}

func main() {
	_ = pointerEscape("demo")
	demo2 := new(Demo) // new(Demo) does not escape
	interfaceEscape(demo2)
}
