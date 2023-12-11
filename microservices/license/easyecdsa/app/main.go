package main

import (
	"crypto/ecdsa"
	"crypto/x509"
	_ "embed"
	"encoding/json"
	"encoding/pem"
	"flag"
	"fmt"
	"github.com/ofey404/experiments/microservices/license/easyecdsa"
	"github.com/zeromicro/go-zero/core/logx"
	"os"
)

// WARNING: this is not a secure way to store a private key in production.
//
//go:embed public_key.pem
var keyBytes []byte

var licensePath = flag.String("license", "license.json", "license key path")

func main() {
	flag.Parse()
	pubkey := loadPublicKey()
	licenseData, err := os.ReadFile(*licensePath)
	logx.Must(err)

	var license easyecdsa.License
	err = json.Unmarshal(licenseData, &license)
	logx.Must(err)

	data, err := license.Verify(pubkey)
	if err != nil {
		fmt.Printf("verify license failed: %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("license data: %v\n", data)
}

func loadPublicKey() *ecdsa.PublicKey {
	// Decode the PEM block containing the public key
	pemBlock, _ := pem.Decode(keyBytes)

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
