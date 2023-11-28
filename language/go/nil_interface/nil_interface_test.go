package main

import (
	"fmt"
	"reflect"
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
	fmt.Printf("Interface is nil: %t\n\n", mp == nil)
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

func TestTheSolution(t *testing.T) {
	fmt.Println("Here we show the solution:")
	var interface1 messagePrinter
	analyzeInterface(interface1)

	fmt.Println("if interface1 == nil || reflect.ValueOf(interface1).IsNil() {")
	if interface1 == nil || reflect.ValueOf(interface1).IsNil() {
		fmt.Println("	interface1 is nil")
	}
	fmt.Println("}")
}

// go test -v .
//
// === RUN   TestNilInterface
// ## t1 := &thing{message: "hello"}
// Interface type: *main.thing
// Interface value: &{hello}
// Interface is nil: false
//
// ## var t2 *thing
// Interface type: *main.thing
// Interface value: <nil>
// Interface is nil: false
//
// ## nil
// Interface type: <nil>
// Interface value: <nil>
// Interface is nil: true
//
// --- PASS: TestNilInterface (0.00s)
// === RUN   TestTheSolution
// Here we show the solution:
// Interface type: <nil>
// Interface value: <nil>
// Interface is nil: true
//
// if interface1 == nil || reflect.ValueOf(interface1).IsNil() {
//         interface1 is nil
// }
// --- PASS: TestTheSolution (0.00s)
// PASS
// ok      github.com/ofey404/experiments/language/go/nil_interface        0.003s
