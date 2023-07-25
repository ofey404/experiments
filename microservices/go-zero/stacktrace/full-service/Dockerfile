FROM ubuntu:22.04

COPY ./bin/backend /usr/local/bin/backend
COPY ./etc/kv.yaml /etc/kv.yaml

ENTRYPOINT [ "/usr/local/bin/backend", "-f", "/etc/kv.yaml" ]
