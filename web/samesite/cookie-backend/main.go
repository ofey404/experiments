package main

import (
	"fmt"
	"net/http"
)

// The cookie setter

const cookieName = "myCookieKey"

func main() {
	addr := "0.0.0.0:8080"
	fmt.Printf("Starting server at %s\n", addr)

	http.HandleFunc("/api/getcookie", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "http://localhost:3000")

		http.SetCookie(
			w,
			&http.Cookie{
				Name:     cookieName,
				Value:    "myCookieValue",
				SameSite: http.SameSiteStrictMode,
			},
		)
	})

	http.HandleFunc("/api/printcookie", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Access-Control-Allow-Origin", "http://localhost:3000")

		c, err := r.Cookie(cookieName)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}

		resp := fmt.Sprintf("Get Cookie: %s\n", c.String())

		fmt.Print(resp) // log to server console

		w.WriteHeader(http.StatusOK) // write to client
		w.Write([]byte(resp))
	})

	err := http.ListenAndServe(addr, nil)
	if err != nil {
		fmt.Println(err)
		return
	}
}
