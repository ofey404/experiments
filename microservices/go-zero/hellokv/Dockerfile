FROM ubuntu:22.04

COPY ./bin/hellokv /usr/local/bin/hellokv
COPY ./etc/hellokv-api.yaml /etc/hellokv-api.yaml

ENTRYPOINT [ "/usr/local/bin/hellokv", "-f", "/etc/hellokv-api.yaml" ]

