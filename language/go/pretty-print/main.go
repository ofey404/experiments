package main

import (
	"encoding/json"
	"fmt"
	"log"
)

type address struct {
	City    string `json:"city"`
	Country string `json:"country"`
}

type employee struct {
	Name    string  `json:"name"`
	Age     int     `json:"age"`
	Salary  int     `json:"salary"`
	Address address `json:"address"`
}

func main() {
	address := address{City: "some_city", Country: "some_country"}
	emp := employee{Name: "Sam", Age: 31, Salary: 2000, Address: address}
	//Converting to json
	empJSON, err := json.MarshalIndent(emp, "", "  ")
	if err != nil {
		log.Fatalf(err.Error())
	}
	fmt.Printf("MarshalIndent funnction output\n %s\n", string(empJSON))
}
