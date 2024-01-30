package main

// Logic is created per-request.
type Logic[Request any, Response any] interface {
	Handle(Request) (Response, error)
}
