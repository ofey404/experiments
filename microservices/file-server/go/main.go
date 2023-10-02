package main

import (
	"flag"
	"log"
	"net/http"
)

// feature:
// 1. download
// 2. middleware authentication
// 3. upload implement at this repo:
//    https://gist.github.com/paulmach/7271283

func mockAuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Println("mockAuthMiddleware is called, it can access the request, decide what to do")
		next.ServeHTTP(w, r)
	})
}

func main() {
	port := flag.String("p", "8100", "port to serve on")
	directory := flag.String("d", ".", "the directory of static file to host")
	flag.Parse()

	http.Handle("/",
		mockAuthMiddleware(http.FileServer(http.Dir(*directory))),
	)

	log.Printf("Serving %s on HTTP port: %s\n", *directory, *port)
	log.Fatal(http.ListenAndServe(":"+*port, nil))
}
