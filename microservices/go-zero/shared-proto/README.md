# shared-proto for go-zero

This directory is an example, to share proto files between multiple services

This is a partial solution:

- It enables importing sharing proto into multiple services
  - common.proto => greeter.proto, greeter2.proto
- But a server's proto cannot import another server's
  - NO: greeter.proto => greeter2.proto
