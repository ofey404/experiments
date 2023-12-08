package main

import (
	"bytes"
	"fmt"
	"text/template"
)

type Person struct {
	Name  string
	Age   int
	City  string
	Email string
}

// go run .
// Name: John Doe, Age: 30, City: New York, Email: johndoe@example.com

func main() {
	person := Person{
		Name:  "John Doe",
		Age:   30,
		City:  "New York",
		Email: "johndoe@example.com",
	}

	tmpl, err := template.New("person").Parse("Name: {{.Name}}, Age: {{.Age}}, City: {{.City}}, Email: {{.Email}}")
	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	var buf bytes.Buffer
	err = tmpl.Execute(&buf, person)
	if err != nil {
		fmt.Println("Error:", err)
		return
	}

	fmt.Println(buf.String())
}
