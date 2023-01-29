package main

import (
	"context"
	"log"

	vault "github.com/hashicorp/vault/api"
)

const (
	token = "dev-only-token" // #nosec G101
	key   = "password2"      // #nosec G101
)

func readSecret(client *vault.Client) {
	// Read a secret
	ctx := context.Background()
	secret, err := client.KVv2("secret").Get(ctx, "my-secret-password")
	if err != nil {
		log.Fatalf("unable to read secret: %v", err)
	}

	value, ok := secret.Data[key].(string)
	if !ok {
		log.Fatalf("value type assertion failed: %T %#v", secret.Data[key], secret.Data[key])
	}

	if value != "Hashi123" {
		log.Fatalf("unexpected password value %q retrieved from vault", value)
	}

	log.Println("Access granted!")
}

func writeSecret(client *vault.Client) {
	ctx := context.Background()
	secretData := map[string]interface{}{
		"password": "Hashi123",
	}

	// Write a secret
	_, err := client.KVv2("secret").Put(ctx, "my-secret-password", secretData)
	if err != nil {
		log.Fatalf("unable to write secret: %v", err)
	}

	log.Println("Secret written successfully.")
}

func main() {
	config := vault.DefaultConfig()

	config.Address = "http://127.0.0.1:8200"

	client, err := vault.NewClient(config)
	if err != nil {
		log.Fatalf("unable to initialize Vault client: %v", err)
	}

	// Authenticate
	// WARNING: This quickstart uses the root token for our Vault dev server.
	// Don't do this in production!
	client.SetToken(token)

	if false {
		writeSecret(client)
	}

	readSecret(client)
}
