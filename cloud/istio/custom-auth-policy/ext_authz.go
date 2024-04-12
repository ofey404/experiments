package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"path"

	"github.com/zeromicro/go-zero/core/logx"
)

type AuthServer struct{}

func NewAuthServer() *AuthServer {
	return &AuthServer{}
}

const (
	checkHeader    = "x-ext-authz"
	allowedValue   = "allow"
	redirectValue  = "redirect"
	resultHeader   = "x-ext-authz-check-result"
	receivedHeader = "x-ext-authz-check-received"
	overrideHeader = "x-ext-authz-additional-header-override"
	resultAllowed  = "allowed"
	resultDenied   = "denied"
)

var denyBody = fmt.Sprintf("denied by ext_authz for not found header `%s: %s` in the request", checkHeader, allowedValue)

func (s *AuthServer) ServeHTTP(response http.ResponseWriter, request *http.Request) {
	body, err := io.ReadAll(request.Body)
	if err != nil {
		log.Printf("[HTTP] read body failed: %v", err)
	}
	l := fmt.Sprintf("%s %s%s, headers: %v, body: [%s]\n", request.Method, request.Host, request.URL, request.Header, body)

	value := request.Header.Get(checkHeader)
	switch value {
	case allowedValue:
		log.Printf("[HTTP][allowed]: %s", l)
		response.Header().Set(resultHeader, resultAllowed)
		response.Header().Set(overrideHeader, request.Header.Get(overrideHeader))
		response.Header().Set(receivedHeader, l)
		response.WriteHeader(http.StatusOK)
	case redirectValue:
		log.Printf("[HTTP][redirect]: %s", l)
		// TODO(ofey404): redirect to login page
		newPath := path.Join("/new", request.URL.Path)

		http.Redirect(response, request, newPath, http.StatusMovedPermanently)
	default:
		log.Printf("[HTTP][denied]: %s", l)
		response.Header().Set(resultHeader, resultDenied)
		response.Header().Set(overrideHeader, request.Header.Get(overrideHeader))
		response.Header().Set(receivedHeader, l)
		response.WriteHeader(http.StatusForbidden)
		_, _ = response.Write([]byte(denyBody))
	}
}

// https://github.com/istio/istio/blob/56314992f1174196e1e74a5339eff1f443f517cd/samples/extauthz/cmd/extauthz/main.go#L260-L280
func main() {
	s := NewAuthServer()
	fmt.Println("Starting server on port 8000")
	logx.Must(http.ListenAndServe(":8000", s))
}
