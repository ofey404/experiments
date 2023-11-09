package main

import "fmt"

func main() {
	var (
		i        = 0
		s        = "str"
		ptr1 any = &i
		ptr2 any = &s
	)

	// illeagal:
	// ii, ss, ok := ptr1.(int), ptr2.(string)
	ii, ok := ptr1.(*int)
	if !ok {
		fmt.Println("ii not ok")
		return
	}
	ss, ok := ptr2.(*string)
	if !ok {
		fmt.Println("ss not ok")
		return
	}
	fmt.Printf("*ii = %d, *ss = %s\n", *ii, *ss)
}
