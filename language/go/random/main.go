package main

import (
	"crypto/rand"
	"encoding/base64"
	"fmt"
)

func generateRandomString(length int) (string, error) {
	// Determine the size of the byte slice needed to store the random string
	byteSlice := make([]byte, length)

	// Fill the byte slice with random bytes
	_, err := rand.Read(byteSlice)
	if err != nil {
		return "", err
	}

	// Encode the random bytes to a base64 string
	randomString := base64.URLEncoding.EncodeToString(byteSlice)

	// Return the random string
	return randomString[:length], nil
}

func main() {
	length := 10
	randomString, err := generateRandomString(length)
	if err != nil {
		fmt.Println("Error generating random string:", err)
		return
	}
	fmt.Printf("Random string, length %d: %s\n", length, randomString)
}

// Output:
//
// go run .
// Random string, length 10: p9z2pQzfx_
