package main

import (
	"log"
	"net/http"

	"github.com/joho/godotenv"

	"github.com/ofey404/experiments/microservices/auth0/01-login/platform/authenticator"
	"github.com/ofey404/experiments/microservices/auth0/01-login/platform/router"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Fatalf("Failed to load the env vars: %v", err)
	}

	auth, err := authenticator.New()
	if err != nil {
		log.Fatalf("Failed to initialize the authenticator: %v", err)
	}

	rtr := router.New(auth)

	log.Print("Server listening on http://localhost:3000/")
	if err := http.ListenAndServe("0.0.0.0:3000", rtr); err != nil {
		log.Fatalf("There was an error with the http server: %v", err)
	}
}
