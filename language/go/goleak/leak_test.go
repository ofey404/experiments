package leak

import (
	"testing"

	"go.uber.org/goleak"
)

func TestSearch(t *testing.T) {
	actual := search()
	defer goleak.VerifyNone(t, goleak.IgnoreCurrent())
	if len(actual) != 2 {
		t.Errorf("actual: %v, wanted: %v", len(actual), 10)
	}
}
