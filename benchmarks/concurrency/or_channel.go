package concurrency

// or returns a read-only channel, that would close if any input channel closes.
func or(lhs <-chan any, rhs ...<-chan any) <-chan any {
	if len(rhs) == 0 {
		return lhs
	}

	orDone := make(chan any)
	go func() {
		defer close(orDone)

		switch len(rhs) {
		case 1: // Put a special case here, to reduce the number of extra channel created.
			select {
			case <-lhs:
			case <-rhs[0]:
			}
		default:
			select {
			case <-lhs:
			case <-rhs[0]:
			case <-rhs[1]:
			case <-or(orDone, rhs[2:]...):
			}
		}
	}()
	return orDone
}
