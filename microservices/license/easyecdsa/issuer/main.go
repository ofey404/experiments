package main

import (
	"crypto/ecdsa"
	"crypto/x509"
	"encoding/pem"
	"flag"
	"fmt"
	"github.com/zeromicro/go-zero/core/logx"
	"os"
)

var privateKeyPath = flag.String("private-key", "private_key.pem", "private key path")

func main() {
	flag.Parse()

	fmt.Println("loading private key from path:", *privateKeyPath)
	privateKey := loadPrivateKey(*privateKeyPath)
	fmt.Println("Private key:", privateKey)
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
