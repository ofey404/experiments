package go_koans

import (
	"os"
	"strings"
)

func aboutFiles() {
	filename := "about_files.go"
	contents, _ := os.ReadFile(filename)
	lines := strings.Split(string(contents), "\n")
	assert(lines[5] == ")") // handling files is too trivial
}
