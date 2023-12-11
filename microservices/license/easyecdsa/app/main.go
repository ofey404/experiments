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

var publicKeyPath = flag.String("public-key", "public_key.pem", "public key path")

func main() {
	flag.Parse()

	fmt.Println("loading public key from path:", *publicKeyPath)
	publicKey := loadPublicKey(*publicKeyPath)
	fmt.Println("Public key:", publicKey)
}

func loadPublicKey(publicKeyPath string) *ecdsa.PublicKey {
	// Read the public key file
	keyBytes, err := os.ReadFile(publicKeyPath)
	logx.Must(err)

	// Decode the PEM block containing the public key
	pemBlock, _ := pem.Decode(keyBytes)
	logx.Must(err)

	// Parse the DER encoded public key
	pubInterface, err := x509.ParsePKIXPublicKey(pemBlock.Bytes)
	logx.Must(err)

	// Type assert the parsed key to *ecdsa.PublicKey
	publicKey, ok := pubInterface.(*ecdsa.PublicKey)
	if !ok {
		fmt.Println("pubInterface wrong type")
		os.Exit(1)
	}
	return publicKey
}
