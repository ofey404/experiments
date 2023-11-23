# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM golang:1.17-buster as builder

WORKDIR /src
COPY . .
RUN GOOS=linux GOARCH=amd64 go build -o /out/hello-world .

FROM debian:buster-slim
COPY --from=builder /out/hello-world /hello-world
ENTRYPOINT ["/hello-world"]
