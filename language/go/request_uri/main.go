package main

import (
	"fmt"
	"net/http"
	"regexp"
	"strings"

	"github.com/zeromicro/go-zero/core/logx"
)

func main() {
	req, err := http.NewRequest(
		http.MethodGet,
		// "http://localhost",
		"http://localhost/request/uri",
		strings.NewReader("key=value"),
	)
	logx.Must(err)
	requestUri := req.URL.RequestURI()
	fmt.Printf("req.URL.RequestURI = %+v\n", requestUri)

	regexString := "^/$"
	fmt.Printf("regexString = %+v\n", regexString)
	re, err := regexp.Compile(regexString)
	logx.Must(err)

	fmt.Printf("re.MatchString(requestUri) = %+v\n", re.MatchString(requestUri))
}
