package go_koans

import (
	"fmt"
	"os"
	"path"
	"runtime"
	"strings"
)

const (
	__string__                     string  = "impossibly lame value"
	__int__                        int     = -1
	__positive_int__               int     = 42
	__byte__                       byte    = 255
	__bool__                       bool    = false // ugh
	__boolean__                    bool    = true  // oh well
	__float32__                    float32 = -1.0
	__delete_me__                  bool    = false
	__this_line_wont_be_executed__         = false
)

var __runner__ runner = nil

func assert(o bool) {
	if !o {
		fmt.Printf("\n%c[35m%s%c[0m\n\n", 27, __getRecentLine(), 27)
		os.Exit(1)
	}
}

func __getRecentLine() string {
	_, file, line, _ := runtime.Caller(2)
	buf, _ := os.ReadFile(file)
	code := strings.TrimSpace(strings.Split(string(buf), "\n")[line-1])
	return fmt.Sprintf("%v:%d\n%s", path.Base(file), line, code)
}
