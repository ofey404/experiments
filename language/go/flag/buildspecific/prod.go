//go:build prod

package buildspecific

import (
	"flag"
	"fmt"
)

var flagOnlyForProd = flag.String("flag-prod", "", "this flag is defined only for production builds")

func PrintFlags() {
	fmt.Println("flagOnlyForProd:", *flagOnlyForProd)
}
