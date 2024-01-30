package main

import "fmt"

// ## Case 1
// Asserted interface{} to []string: [apple banana cherry]
// ## Case 2
// Asserted []interface{} to []string: [apple banana cherry]

func main() {
	case1()
	case2()
}

func case1() {
	fmt.Println("## Case 1")
	var data interface{}
	data = []string{"apple", "banana", "cherry"}

	// Assert the interface{} to []string
	if strSlice, ok := data.([]string); ok {
		fmt.Println("Asserted interface{} to []string:", strSlice)
	} else {
		fmt.Println("Failed to assert to []string")
	}
}

func case2() {
	fmt.Println("## Case 2")
	group := []interface{}{"apple", "banana", "cherry"}
	strSlice := convertToStringSlice(group)
	fmt.Println("Asserted []interface{} to []string:", strSlice)
}

func convertToStringSlice(data []interface{}) []string {
	var result []string
	for _, item := range data {
		if str, ok := item.(string); ok {
			result = append(result, str)
		} else {
			fmt.Println("Failed to assert to string:", item)
		}
	}
	return result
}
