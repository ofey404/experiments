# Takeaway of Concurrency in Go

# Chapter 1: Introduction

What do we mean when we say 'concurrency'?

- Multiple things are making progress at the same time.

Amdahl's law

Embarrassing parallel

Web-scale software



In handling race conditions, you should always target logical correctness.



Atomicity means indivisible, uninterruptable.

Glider vs. Blizzard: Atomicity must be within contexts.



# Chapter 2: Modeling Your Code: Communicating Sequential Processes

Concurrency is a property of the code; parallelism is of the running program.

[Tony Hoare - Wikipedia](https://en.wikipedia.org/wiki/Tony_Hoare): Golang borrows several concepts from him.

Goroutine doesn't add difficulties; instead, it supplants OS threads.



Hoare's CSP: Communicating Sequential Processes.

From CSP to Process Calculus: IO should be programming primitive.

The shared memory model can be challenging to utilize correctly, that is, hard to read/reason about.



Don't worry about creating a goroutine; that's the fundamental promise golang makes to us.



The syntax of language doesn't matter, at least not so much... The important thing is how they model problems.



A quote demonstrates the difference between the two models:

- Don't communicate by sharing memory. Instead, share memory by communicating.



A metaphor about the two models:

1. Sharing memory: writing on one and only one bulletin board. (Like XYZ in City Hunter)
   1. It models a central state.
2. CSP: writing in shared, disposable email. Fire and forget missile.
   1. It models ownership transfer.
   2. It's naturally more composable.
   3. It's a higher-level abstraction - communication should be cheap to support this.



# Chapter 3: Go's Concurrency Building Blocks

`M:N` scheduler is the goroutine hosting mechanism.

1. Goroutines -> M Green threads -> N OS threads.



Situations to use `WaitGroup`:

1. You don't care about the result of concurrent operations.
2. You have other means to collect results.



Put `Add()` outside of `Done()` goroutine, or you'll introduce a race condition.



`sync.NewCond()`



According to the Channel Owner Principle, the owner should:

1. Make the channel.
2. Perform writes, or pass ownership to another goroutine.
3. Close the channel.
4. Expose a reader channel.



# Chapter 4: Concurrency Patterns in Go

We recommend exposing only the correct data and concurrency primitive for multiple processes to use. That's called confinement.



If something creates a goroutine, it's also responsible for stopping it.

- This convention would ensure your programming can compose and scale.



In the goroutine's error handling, we should send its error to another part of the program, which has complete runtime information.



Good materials: [有哪些值得学习的 Go 语言开源项目？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/20801814/answer/1534555951)



Uber golang style guide: [guide/style.md at master · uber-go/guide (github.com)](https://github.com/uber-go/guide/blob/master/style.md)



# Chapter 5

Errors can be placed into two categories:

1. Bugs
2. Know edge cases (e.g., broken network connections)



Passing raw errors are always a bug, except in the first few iterations of your alpha system.



The user-oriented error should provide a unique log ID for users to find more information if they want.



By setting a timeout to prevent deadlock, we can get a system with a live-lock, which would recover in a reasonable time.

1. It's not a suggested way to build a correct system but rather a way to construct a timing-error-tolerant system.



There are two significant problems in canceling concurrent processes:

1. At which point does a concurrent process to be preemptable?
2. How to discard and rollback intermediate state?



Heartbeat, or bidirectional communication, could prevent duplicated messages.



Most rate limiting is implemented by the token bucket.

1. The `MultiLimiter` design is so beautiful, and totally composable.

```go
err := MultiLimiter(a.apiLimit, a.networkLimit).Wait(ctx)
```



The insight from the work-stealing algorithm:

1. The most recently used task is less likely to be stolen.
   1. This task is more likely to complete the parent's join.
   2. More likely to remain in the processor cache.



The basic assumption is that the task does the work, and the continuation waits for rejoin.

1. So, stealing the continuation makes our tasks hit the road immediately.

2. Also, continuation is more likely to be picked after the processor completes its task.
3. On a single processor, continuation stealing fallbacks to functions.

```go
go func() {
    var wg WaitGroup
    // wait here?
}
// continuation can't get wg from outside.
// so, it's always continuation waiting for tasks.
```

