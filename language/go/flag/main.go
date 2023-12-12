package main

import (
	"flag"
	"fmt"
	"github.com/ofey404/experiments/language/go/flag/buildspecific"
)

var flag1 = flag.String("flag1", "", "this flag is defined for all builds")

func main() {
	flag.Parse()
	fmt.Println("flag1:", *flag1)
	buildspecific.PrintFlags()
}

// Dev build:
//
// go run . --help
// Usage of /tmp/go-build315234069/b001/exe/flag:
// -flag-dev string
// this flag is defined only for dev builds
// -flag1 string
// this flag is defined for all builds
//
// go run . -flag1=111 -flag-dev=222
// flag1: 111
// flagOnlyForDev: 222

// Prod build:
//
// go run -tags=prod . --help
// Usage of /tmp/go-build1209116740/b001/exe/flag:
// -flag-prod string
// this flag is defined only for production builds
// -flag1 string
// this flag is defined for all builds
//
// go run -tags=prod . -flag1=111 -flag-prod=222
// flag1: 111
// flagOnlyForProd: 222
