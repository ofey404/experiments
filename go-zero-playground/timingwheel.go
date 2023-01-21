package main

import (
	"fmt"
	"os"
	"time"

	"github.com/zeromicro/go-zero/core/collection"
	"github.com/zeromicro/go-zero/core/logx"
)

type Poller struct {
	Tw *collection.TimingWheel
}

func (p *Poller) Start() {
	tw, err := collection.NewTimingWheel(
		time.Second/2,
		60,
		p.execute,
	)
	logx.Must(err)

	p.Tw = tw
}

func (p *Poller) execute(k, v any) {
	fmt.Println("key: ", k)
	fmt.Println("value: ", v)
	count, ok := v.(int)
	if !ok {
		logx.Error("not ok")
		os.Exit(1)
	}

	count++
	_ = p.Tw.SetTimer(k, count, time.Second)
}

/*
Expected output
---------------

key:  key
value:  0
key:  key
value:  1
key:  key
value:  2
key:  key
value:  3
*/
func main() {
	p := Poller{}
	p.Start()
	_ = p.Tw.SetTimer("key", 0, time.Second)
	time.Sleep(time.Minute)
}
