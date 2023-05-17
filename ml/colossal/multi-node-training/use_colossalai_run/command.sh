grpcurl -plaintext 10.0.10.134:8081 list

grpcurl -plaintext 10.0.10.134:8081 list resourcemanager.ResourceManager

grpcurl -plaintext -d '{
  "instance_type": 4,
  "size": 2,
  "job_id": "999"
}' 10.0.10.134:8081 resourcemanager.ResourceManager/create

colossalai run \
           --nproc_per_node 1 \
           /mnt/project/train.py \
           --config /mnt/project/config.py \
           --optimizer lars \
           --synthetic \
           --host 10.0.10.160,10.0.10.65 \
           --master_addr 10.0.10.160 \
           --output /output/model

colossalai run \
           --nproc_per_node 1 \
           /mnt/project/train.py \
           --config /mnt/project/config.py \
           --optimizer lars \
           --synthetic \
           --host 10-0-10-160.default.pod.cluster.local,10-0-10-65.default.pod.cluster.local \
           --master_addr 10-0-10-160.default.pod.cluster.local \
           --output /output/model

10-0-10-91.default.pod.cluster.local

kubectl cp code/ default/multi-node-training-5674586b69-kskh9:/mnt/project/
# 10.0.10.160

kubectl cp code/ default/multi-node-training-5674586b69-qs7zd:/mnt/project/
# 10.0.10.65

kubectl cp ssh default/multi-node-training-5674586b69-kskh9:/root/.ssh
kubectl cp ssh default/multi-node-training-5674586b69-qs7zd:/root/.ssh

ssh root@10-0-10-160.default.pod.cluster.local
ssh root@10-0-10-65.default.pod.cluster.local

mkdir -p -m0755 /run/sshd
/usr/sbin/sshd
mkdir -p /output/model

yes '' | ssh-keygen -N ''

cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

cat <<EOF >> ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJOv8fGhHRk4IbhIarCG0h8jxEtcpSPTKJr9uJM/ON0Ls2tqQWxQrtzRc0/h3M94Eo8ttxeYj68i64VSxp2zbeXhATSO9cEGH9FLcvaSXgWtsAjGt8a3HzdBc2mWDQ3/bDlWrdEF2OSQUE794Dc/S2Jym0efgpTGg/joC1PyIDQGdsg4rR/Mz7bmwl/27L42tr+Yo3TdXXn47ypyl78yUOL5dxhXGuAOOkz0DIlTkt7riL0EQ+RaGKY6I5jB7+JW5PiIMrFbOQQC2gWxvvlUjbmRCafRW3Lq3cXnn1ZCutT3rod0OcWu+ZJipPH4WRHiVX8yz4M6Bg9vvS4AvnpJrlLNHnvu9j3oEbqRrD9QCsA4WeUZJzlI64YNYOyC4Ap2nqPz88SJqaRUit0AGdAyX/wDEvUzIUGqPZLzFP6PCS2GIbmZwbVgdA+iZW6+LSu4kqWZXvz3l1bJfHPcR9gpeV+n6o7N3VjpSXITp2BtQKHAk/METFjtyA5KjByUIpN3k= root@multi-node-training-5674586b69-2fpqd
EOF

cat <<EOF >> ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDQuEfIqU9rL+fE8pyb1WXenz2mxtmIx6LP3mU9Bvyw/d4jW80EzYhHFqXSzw+pGij5pVpGTFk1990sIjx+1YRd3JiiSABa/dXVd44hQYrbfKOUYwYSR4NLV6worOZ1DL+WYE7/j2gKBDY2DTBBqfcfKZtvAUWklRSERJY20RtD0CFCZXAeeLOQsgfhEJ+xQboFKrP1vjDaTbdZ8PMa+7KeLXv/xg5jdlJDHa77YoERG5b5/VKg7QSaqMNT2pVnG8AEjtPSJWiGCT+DSGD4s06rqL0ceyVhtDmctWy0TzrhLr4dof9Y+3MnVYy5nzhb5zoVLRx8VnVct5sK5QPSM3wUen8Voo2FPur2C5vRPd62u6bxaju6W3M4sngDsEBhVX8w1Y72Xc/7dkmmydYALrS2Z0gdx3Me2TgkDZ38Ujc2hwmHg6HMhRZ5jzHySFARPCiH2TluOqI4GHJiZuLvZ36wf9sLiac/MZYQBURGeVbljDApCiCdCHp4qkgsPxmQOM= root@multi-node-training-5674586b69-z9b79
EOF


vim /opt/conda/lib/python3.9/site-packages/colossalai/cli/launcher/run.py

torchrun --nproc_per_node=1 --nnodes=2 --node_rank=0 --rdzv_backend=c10d --rdzv_endpoint=10-0-10-160.default.pod.cluster.local:29500 --rdzv_id=colossalai-default-job /mnt/project/train.py --config /mnt/project/config.py --optimizer lars --synthetic --output /output/model

torchrun --nproc_per_node=1 --nnodes=2 --node_rank=1 --rdzv_backend=c10d --rdzv_endpoint=10-0-10-160.default.pod.cluster.local:29500 --rdzv_id=colossalai-default-job /mnt/project/train.py --config /mnt/project/config.py --optimizer lars --synthetic --output /output/model

## try host network

colossalai run \
           --nproc_per_node 1 \
           /mnt/project/train.py \
           --config /mnt/project/config.py \
           --optimizer lars \
           --synthetic \
           --host 10.0.10.82,10.0.10.210 \
           --master_addr 10.0.10.82 \
           --output /output/model
