package main

import (
	"github.com/ofey404/experiments/basic_bench"
	"github.com/pkg/profile"
)

func funcNeedProf() {
	_ = basic_bench.Fib(43)
}

func main() {
	defer profile.Start(
		profile.ProfilePath("./out"),
	).Stop()
	_ = basic_bench.Fib(43)
	funcNeedProf()
}
