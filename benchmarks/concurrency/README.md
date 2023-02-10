# Concurrency in Go: Tools and Techniques for Developers

Book by Katherine Cox-Buday

This directory contains some experiments from this book.

[Go 语言高性能编程](https://geektutu.com/post/high-performance-go.html):
We can refer to this, as supplemental material.

# generator pattern efficiency

## overhead of one level

About 500 ns.

```
BenchmarkPipeline1-2        	 2108330	       562.4 ns/op	       8 B/op	       1 allocs/op
BenchmarkPipeline2-2        	 1382781	       889.0 ns/op	       8 B/op	       1 allocs/op
```

So, if our workload could cover this overhead, eg: workload takes 5000 ns,
it's proper to introduce a level of pipeline.

As core number increasing, the efficiency drops. Why?

## scalability

Linear as pipeline level grows.

```
BenchmarkPipeline1-2        	 2108330	       562.4 ns/op	       8 B/op	       1 allocs/op
BenchmarkPipeline10-2       	  355516	      3387 ns/op	       8 B/op	       1 allocs/op
BenchmarkPipeline100-2      	   35031	     31902 ns/op	       8 B/op	       1 allocs/op
BenchmarkPipeline1000-2     	    6376	    331848 ns/op	      35 B/op	       1 allocs/op
```

## core number

TODO(ofey404): More cores, low performance.

Why? We expect no performance drop.

```
BenchmarkPipeline10-2       	  355516	      3387 ns/op	       8 B/op	       1 allocs/op
BenchmarkPipeline10-16      	  193882	      6129 ns/op	       8 B/op	       1 allocs/op
```

# pprof
