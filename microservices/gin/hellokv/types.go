package main

type SetRequest struct {
	Key   string `json:"key"`
	Value string `json:"value"`
}

type GetRequest struct {
	Key string `json:"key"`
}

type GetResponse struct {
	Value string `json:"value"`
}

type EmptyResponse struct{}
