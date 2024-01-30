package main

import (
	"encoding/json"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/lestrrat-go/jwx/v2/jwa"
	"github.com/lestrrat-go/jwx/v2/jwk"
	"github.com/lestrrat-go/jwx/v2/jwt"
	"github.com/urfave/cli/v2"
)

func main() {
	var JwkFilePath cli.Path
	var Subject string

	app := &cli.App{
		Name:  "generator",
		Usage: "Generate a JWT token",
		Flags: []cli.Flag{
			&cli.PathFlag{
				Name:        "jwk",
				Usage:       "Path to the JWK file",
				Required:    true,
				Destination: &JwkFilePath,
			},
			&cli.StringFlag{
				Name:        "sub",
				Usage:       "JWT subject key",
				Value:       "ofey404",
				Destination: &Subject,
			},
		},
		Action: func(cCtx *cli.Context) error {
			fmt.Printf("JwkFilePath %q\n", JwkFilePath)

			b, err := os.ReadFile(JwkFilePath)
			if err != nil {
				return err
			}
			jwkStr := string(b)
			t := jwt.New()
			t.Set(jwt.IssuerKey, `ofey404@test.com`)
			t.Set(jwt.SubjectKey, Subject)
			t.Set(jwt.AudienceKey, `Golang Users`)
			t.Set(jwt.IssuedAtKey, time.Unix(500, 0))

			buf, err := json.MarshalIndent(t, "", "  ")
			if err != nil {
				fmt.Printf("failed to generate JSON: %s\n", err)
				return err
			}

			fmt.Printf("## Buffer:\n%s\n", buf)

			//convert jwk in bytes and return a new key
			jwkey, err := jwk.ParseKey([]byte(jwkStr))
			if err != nil {
				return err
			}

			// signed and return a jwt
			signed, err := jwt.Sign(t, jwt.WithKey(jwa.RS256, jwkey))
			if err != nil {
				return err
			}

			signedString := string(signed[:])
			fmt.Printf("## Signed key\n%s\n", signedString)

			//_, err = jwt.Parse([]byte(signedString), jwt.WithKey(jwa.RS256, jwkey))
			_, err = jwt.Parse(signed, jwt.WithKey(jwa.RS256, jwkey))
			if err != nil {
				return err
			}

			return nil
		},
	}

	if err := app.Run(os.Args); err != nil {
		log.Fatal(err)
	}
}
