package main

import (
	"fmt"
	"reflect"
	"runtime"

	"github.com/zeromicro/go-zero/core/logx"

	"github.com/pkg/errors"
)

// handleWrappedError examines the behavior of errors.Wrap()
func handleWrappedError(e error, handler func(error)) {
	fmt.Print("## Enter error hander\n")
	funcName := runtime.FuncForPC(reflect.ValueOf(handler).Pointer()).Name()
	fmt.Printf("handler: %s\n", funcName)
	handler(e)
	fmt.Print("## Exit error hander\n")
}

func toUser(s string) {
	fmt.Printf("## To User:\n%s\n", s)
}

func main() {
	logicError := errors.New("logic error, should only go to log")
	internalServiceError := errors.New("500 Internal Service Error, return to user")

	handleWrappedError(
		errors.Wrap(internalServiceError, logicError.Error()),
		//basicHandler,
		unwrapHandler,
		//logxHandler,
	)
}

// ## Enter error hander
// handler: main.basicHandler
// 500 Internal Service Error, return to user
// main.main
// /home/ofey/experiments/microservices/go-zero/stacktrace/main.go:58
// runtime.main
// /usr/local/go/src/runtime/proc.go:250
// runtime.goexit
// /usr/local/go/src/runtime/asm_amd64.s:1598
// logic error, should only go to log
// main.main
// /home/ofey/experiments/microservices/go-zero/stacktrace/main.go:61
// runtime.main
// /usr/local/go/src/runtime/proc.go:250
// runtime.goexit
// /usr/local/go/src/runtime/asm_amd64.s:1598
// ## Exit error hander
func basicHandler(e error) {
	fmt.Printf("%+v\n", e)
}

// ## Enter error hander
// handler: main.unwrapHandler
// ## To Log:
// logic error, should only go to log: 500 Internal Service Error, return to user
// ## To User:
// 500 Internal Service Error, return to user
// ## Exit error hander
func unwrapHandler(e error) {
	fmt.Printf("## To Log:\n%s\n", e.Error())
	err := errors.Cause(e)
	toUser(err.Error())
}

// ## Enter error hander
// handler: main.logxHandler
// {"@timestamp":"2023-07-25T15:39:38.615+08:00","caller":"stacktrace/main.go:36","content":"logic error, should only go to log: 500 Internal Service Error, return to user","level":"error"}
// ## Exit error hander
func logxHandler(e error) {
	logx.Errorf(e.Error())
}
