//go:build !prod

package buildspecific

import (
	"flag"
	"fmt"
)

var flagOnlyForDev = flag.String("flag-dev", "", "this flag is defined only for dev builds")

func PrintFlags() {
	fmt.Println("flagOnlyForDev:", *flagOnlyForDev)
}
