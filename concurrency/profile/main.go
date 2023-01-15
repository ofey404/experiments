package main

import (
	"github.com/ofey404/experiments/concurrency"
	"github.com/pkg/profile"
)

func main() {
	defer profile.Start(
		profile.ProfilePath("./out"),
	).Stop()
	done := make(chan any)
	s := concurrency.MultiLevelPipeline(done, 10, 10000)
	for range s {
	}
}
