package main

import (
	"crypto/ecdsa"
	"crypto/x509"
	"encoding/json"
	"encoding/pem"
	"flag"
	"fmt"
	"github.com/ofey404/experiments/microservices/license/easyecdsa"
	"github.com/zeromicro/go-zero/core/logx"
	"os"
	"time"
)

var privateKeyPath = flag.String("private-key", "private_key.pem", "private key path")
var outputPath = flag.String("o", "license.json", "license key path")

func main() {
	flag.Parse()

	fmt.Println("loading private key from path:", *privateKeyPath)
	privateKey := loadPrivateKey(*privateKeyPath)

	license := easyecdsa.NewLicense(privateKey, easyecdsa.LicenseData{
		Email: "test@example.com",
		End:   time.Now().Add(time.Hour * 24 * 365), // 1 year
	})

	// Convert the Person object to JSON
	jsonData, err := json.MarshalIndent(license, "", "    ")
	logx.Must(err)

	// Write the JSON data to a file
	err = os.WriteFile(*outputPath, jsonData, 0644)
	logx.Must(err)

	fmt.Printf("license dumped into %s\n", *outputPath)
}

func loadPrivateKey(privateKeyPath string) *ecdsa.PrivateKey {
	// Read the private key file
	keyBytes, err := os.ReadFile(privateKeyPath)
	logx.Must(err)

	// Decode the PEM block containing the private key
	pemBlock, _ := pem.Decode(keyBytes)
	if pemBlock == nil {
		fmt.Printf("failed to decode PEM block from private key file")
		os.Exit(1)
	}

	// Parse the DER encoded private key
	privateKey, err := x509.ParseECPrivateKey(pemBlock.Bytes)
	logx.Must(err)

	return privateKey
}
