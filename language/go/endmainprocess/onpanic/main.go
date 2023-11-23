package main

import (
	"fmt"
)

func main() {
	oneOfThemClosed := make(chan struct{})

	go func() {
		fmt.Println("func 1")
		panic("func 1 panic")

		close(oneOfThemClosed)
		fmt.Println("func 1 closed")
	}()
	go func() {
		for {
			fmt.Println("func 2 intend to run forever")
		}
	}()

	<-oneOfThemClosed
	fmt.Println("but as func 1 closed, the main process would shut down")
}
