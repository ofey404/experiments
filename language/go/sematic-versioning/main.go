package main

import (
	"fmt"
	"github.com/Masterminds/semver"
)

func main() {
	v, err := semver.NewVersion("1.2")
	if err != nil {
		fmt.Printf("Error parsing version: %s", err)
		return
	}

	fmt.Printf("Major: %d\n", v.Major())
	fmt.Printf("Minor: %d\n", v.Minor())
	fmt.Printf("Patch: %d\n", v.Patch())
	fmt.Printf("Original: %s\n", v.Original())
}
