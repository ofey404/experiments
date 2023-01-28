# Escape analysis

Alloc variable on stack is faster, but requires a copy operation.

On heap could reduce copy, but causes pressure on GC.

This directory contains experiments on escape analysis.

## References

- [Go 逃逸分析](https://geektutu.com/post/hpg-escape-analysis.html)
  https://faun.pub/golang-escape-analysis-reduce-pressure-on-gc-6bde1891d625