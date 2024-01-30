package main

import (
	"crypto/rand"
	"crypto/rsa"
	"crypto/x509"
	"encoding/base64"
	"encoding/pem"
	"fmt"
	"io"
	"os"
)

func main() {
	base64Data, err := io.ReadAll(os.Stdin)
	if err != nil {
		panic(err)
	}

	data, err := base64.StdEncoding.DecodeString(string(base64Data))
	if err != nil {
		panic(err)
	}

	decrypted, err := rsa.DecryptPKCS1v15(rand.Reader, getPrivateKey(), data)
	if err != nil {
		panic(err)
	}

	fmt.Printf("Decrypted: %s\n", decrypted)
}

func getPrivateKey() *rsa.PrivateKey {
	privatePEMData := []byte(`-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCtP4NOzFnyk0j1
YUEzDaeMQcQBtHGtokq+2fOiu1SHGixITfF/gNkBrJdFrDAvL5et1cbyYIcdw6D6
4veLhIRz+WHWCQWaq2hDTwR6jFj0yA1fCn1w74n9QwQcVg9qEnC7j7c83lML43Eg
3BkNnf7+bkpezmyU10RXPoX9n5qQu5Vk8akbthnuCDWoCAjEXYPu1C+cNHq1k6nc
yULyQlyTLAoavoEslG4tlCAYR/v1d1nq/vjSejXVoEe2uBXaSf16thMEQRSM4gai
KaW1IwbrGJo5l0WukydqTcilq4G2989pcwUi0YJ1mMIKl06BlXfN2WFQ8c5xXu+3
DPV8IeyHAgMBAAECggEATJxD3/H8qoiX4C5gCwf0OdERMGHPTSVxoSC3HJRzJgUc
ZOLWsnfTPmrIP/6LFiqZC713atHlnfNWuero5XC1s6UpLuExcbpvcig8hkaOxbu7
MfZtDyZV4kEizbb+vPynjkFYmZmEpsKuUYYSrBNcYb16tJ7apBznMx9KWCOeUXZv
aw930H0PPLrx55pTVSgdxVeFU0Oa3elJIfEXpa7K/HMlLtUjZD0YWgF+sonyc3AW
scRqPrBH/enf1K3NQg+LBC7vcucNINe/4+HE9chY0woTWbxU1AmZ4koQ3Un33wDK
8NesLadanq43dlif51SfunxVYVDjVCgVxGDsAejvWQKBgQDeYX7cyf0YGeZW3RRv
r8IsO5iK192vSuRiEEGF64pfzEmB9Gs3fSqX6SlYwtKzSNcHoDlGNBVE8vHW9DpQ
e+U/SrOYgcMU4eiILJS1x/l0wD8GA3XVn6s+76vVTvOdjmgchGe13n2bGU8nEv+M
vO3sIkYCfD0bkZiZfdwN6tNDLwKBgQDHcH/TAtF93vFkBQRGt4PggDrkK+ZFoOCE
pYzg8yPEp8WlINdfohjVLyteq2OwBe7PgjJ+6SgYEt10apVSW4CXBahjf/T7SrL1
7Dk09J6dPuF9h1On37+tMHrjKDGRNj41xEDNBcOWiI7k7gH1zo+ftmevd2Y88jcr
CV+c4tP2KQKBgQClnaaFeEjtshxBhNS7eQH7P0cT4EBRVE1SWxjxS8H6JoJ4LjfL
U4RtLlCEslOJAi5il4kQJ6nPd790ft8PIbZRtKicY8eNvdEX2VvHJe86bBKDv//5
4LgAXy5x5iK4rF4NHu6+G70fzXGNgDCh9/KZcc0B/NTlu0ESzxEbrE86MQKBgGUP
a6ZIQlGO/DDbnewbp/bF45GlcR0NRVfR7845RoGrJirjtl8ea4jzSv3AyVXz26xI
5D+M9CUmwhLww1OlTEa6tjYdK81+b6rQFbjwz8MMjwSl400owx8Gdu7OejeEDgf+
t3tslUydTBNTS6j8D6k1q9qtHSB6+FuVd16vTgrpAoGAFS16OkyEDsIx54eVpLpw
7sANWcjq5zt3k/6PrCDqZEBLPYbOcHH3o0JPjszyElGRdDvS99cCkk37I50OOzFL
zeHHIad5IqUycRWSoBqoaCRfP5Pm+xBUYqRmSLrsp6h5mwp+hfE0+MCeoy6PlJRS
DLNZV1ib3Y5/A7rXI67o1/k=
-----END PRIVATE KEY-----`)

	block, _ := pem.Decode(privatePEMData)
	k, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		panic(err)
	}
	return k.(*rsa.PrivateKey)
}
