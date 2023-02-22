# docker-compose partial start

Requirements:

1. service `useless_dependency` should not start.
2. `go run ...` can access service `pingpong` from host.

## 2. Expose docker network to host

https://stackoverflow.com/questions/39070547/how-to-expose-a-docker-network-to-the-host-machine

This repo use a DNS proxy to do this: https://github.com/hiroshi/docker-dns-proxy

In WSL, make /etc/resolv.conf change permanent: https://github.com/microsoft/WSL/issues/5420
