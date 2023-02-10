package concurrency

import (
	"testing"
	"time"
)

func Test_or(t *testing.T) {
	combine := func(n int) func() []<-chan any {
		return func() (channels []<-chan any) {
			if n == 0 {
				t.Fatal("n should >= 1")
				return nil
			}

			for i := 0; i < n; i++ {
				timeOut := make(chan any)
				channels = append(channels, timeOut)

				go func() {
					time.Sleep(10 * time.Microsecond)
					close(timeOut)
				}()
			}
			return channels
		}
	}

	tests := []struct {
		name     string
		channels func() []<-chan any
		isNil    bool
	}{
		{
			name:     "base",
			channels: combine(3),
		},
		{
			name:     "more channels",
			channels: combine(100),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			channels := tt.channels()
			if len(channels) == 0 {
				t.Error("test should contain one or more channels.")
			}

			done := or(channels[0], channels[1:]...)
			select {
			case <-done:
				return
			case <-time.After(time.Second):
				t.Fatal("timeout")
			}
		})
	}
}
