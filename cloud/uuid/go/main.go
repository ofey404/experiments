package main

import (
	"fmt"

	"github.com/google/uuid"
)

// https://pkg.go.dev/github.com/google/uuid
func main() {
	id := uuid.New()
	fmt.Printf("UUID: %s\n", id.String())
}
