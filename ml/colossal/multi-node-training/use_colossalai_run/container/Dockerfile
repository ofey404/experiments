FROM hpcaitech/colossalai:0.2.5

COPY config /root/.ssh/config

RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys