package easyecdsa

import (
	"crypto/ecdsa"
	"crypto/rand"
	"crypto/sha256"
	"encoding/json"
	"errors"
	"github.com/zeromicro/go-zero/core/logx"
	"time"
)

type LicenseData struct {
	Email string    `json:"email"`
	End   time.Time `json:"end"`
}

// License represents a license with some data and a hash.
type License struct {
	Data []byte
	// Signature is the ASN.1 encoded signature of Data's sha256 hash digest.
	Signature []byte
}

func (l *License) Verify(publicKey *ecdsa.PublicKey) (LicenseData, error) {
	hash := sha256.Sum256(l.Data)

	if ecdsa.VerifyASN1(publicKey, hash[:], l.Signature) {
		var data LicenseData
		err := json.Unmarshal(l.Data, &data)
		logx.Must(err)
		return data, nil
	} else {
		return LicenseData{}, errors.New("invalid license signature")
	}
}

func NewLicense(privateKey *ecdsa.PrivateKey, data LicenseData) *License {
	d, err := json.Marshal(data)
	logx.Must(err)

	license := &License{Data: d}

	// Create signature of the data
	hash := sha256.Sum256(license.Data)
	signature, err := ecdsa.SignASN1(rand.Reader, privateKey, hash[:])
	logx.Must(err)
	license.Signature = signature

	return license
}
