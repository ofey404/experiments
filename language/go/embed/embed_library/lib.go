package embed_library

import (
	_ "embed"
)

//go:embed embed_file.txt
var EmbedFile string
