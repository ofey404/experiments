package main

import (
	"flag"
	"sync"
	"time"
)

var m = map[string]int{"a": 1}
var lock = sync.RWMutex{}

var isUnsafe = flag.Bool("unsafe", false, "access map without lock")

func main() {
	flag.Parse()

	go Read(*isUnsafe)
	time.Sleep(1 * time.Second)
	go Write(*isUnsafe)
	time.Sleep(10 * time.Second)
}

func Read(unsafe bool) {
	for {
		if unsafe {
			unsafeRead()
		} else {
			read()
		}
	}
}

func Write(unsafe bool) {
	for {
		if unsafe {
			unsafeWrite()
		} else {
			write()
		}
	}
}

func read() {
	lock.RLock()
	defer lock.RUnlock()
	_ = m["a"]
}

func write() {
	lock.Lock()
	defer lock.Unlock()
	m["b"] = 2
}

func unsafeRead() {
	//lock.RLock()
	//defer lock.RUnlock()
	_ = m["a"]
}

func unsafeWrite() {
	//lock.Lock()
	//defer lock.Unlock()
	m["b"] = 2
}
