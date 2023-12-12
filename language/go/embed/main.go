package main

import (
	"fmt"
	"github.com/ofey404/experiments/language/go/embed/embed_library"
)

func main() {
	fmt.Printf("embed file content: %s\n", embed_library.EmbedFile)
}

// go run .
// embed file content: Hello, World!
