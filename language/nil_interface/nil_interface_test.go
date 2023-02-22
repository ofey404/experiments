package main

import (
	"fmt"
	"testing"
)

type messagePrinter interface {
	printMessage()
}

type thing struct {
	message string
}

func (t thing) printMessage() {
	fmt.Printf("Message: %s\n", t.message)
}

func analyzeInterface(mp messagePrinter) {
	fmt.Printf("Interface type: %T\n", mp)
	fmt.Printf("Interface value: %v\n", mp)
	fmt.Printf("Interface is nil: %t\n", mp == nil)
}

func TestNilInterface(t *testing.T) {
	t1 := &thing{message: "hello"}
	fmt.Println("## t1 := &thing{message: \"hello\"}")
	analyzeInterface(t1)

	var t2 *thing
	fmt.Println("## var t2 *thing")
	analyzeInterface(t2)

	fmt.Println("## nil")
	analyzeInterface(nil)
}
