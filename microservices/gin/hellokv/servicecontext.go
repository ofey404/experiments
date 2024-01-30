package main

type ServiceContext struct {
	KV map[string]string
}

func NewServiceContext() *ServiceContext {
	return &ServiceContext{
		KV: make(map[string]string),
	}
}
