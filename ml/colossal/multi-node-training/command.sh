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

cat <<EOF >> ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDImNd1HndCiRb+MIIjfUpzhUS7rN1RM65/AjNirP+uFVGreu95XJNPDYBfhBpELGYwLVq7ZqTzNch6/C40qS2pcGqqyoz7HLf9pfFH++dDhXqvEPa81eSQukbJOnVDG4u7iVSNf5rwE9hWPD07z12n4pqMQZfUnI1sZRU34ZqgdO2E1r094mRWw3p0hTu9WMixhyn4cgJyVlKxhUIXqiZxPCmMtfiBuL6sFBYdfBUhIXr0q71x9U4t7IRZgpA2T6Ict1QWA3e6Mw7rv/gMemdR2PhfuaL1OUuLcqZNOl/5aTcKNf+vduh7SprzgZ/q4n3rzrdf6p2aILWWdPIO7m7WMDFodNGxB/1NQo9m2NVBMpQfU6vrfltht/7q3c1r+4ILx62exs7Hfa7Ipqdh0Foja/kPGLVq7gkn08CmOCZXfgh2rGG5DC6WefoGpKeHahfqXOY33ATzATX9dMEjaIqBa10YiIw+o40WFC7GTqpS8O7eqHG333/MVE20EPqewI8= root@multi-node-training-5674586b69-kskh9
EOF

cat <<EOF >> ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCnFEBO7bvAfsHBcQxM0swyMDLqPKUGKCU5+xCCDeAnqBDQ+Erw+d/9b23S02iCrGW3Jvpex4hJZRU0Zt3vfiseml43kulScMI+TKtCDF9qmRRMgWXUdqTJwhmH6zyFfAbFP5be+oVOZYbKI9Qmcvk7uX6+kwM8gEaYvEi3/a+LDVie396Eg0iYXNUBHuK3mHdWVguklOI4dt2ZyEh5Pqks4LncXOmHnfW2UXCtBUR7dtORJvszSiDNblOabnvVxXcq1GNsH2/jvKVU2T6HuUs0KGkjNSENo8/HheE8uuqNwws322msAn2bZ+hzekglvpQVGwoTMHqzfRrJ7W3+uRVrN7Izs7AFs1BSO6na2o5DDdQWxfev4VFex10zGs8ixydMZPRLQApcVoF5iCtOJkiMFMW3AjvalbzxxkfMOGPwDtWiJgVU0IrZQhCsDwquaUsce4OIgwRQTN5tUa4sbBil+FaUsyJIWgNqVI4UlHcXjK17d5j1fTABCpzaMs+d/ds= root@multi-node-training-5674586b69-qs7zd
EOF


vim /opt/conda/lib/python3.9/site-packages/colossalai/cli/launcher/run.py

torchrun --nproc_per_node=1 --nnodes=2 --node_rank=0 --rdzv_backend=c10d --rdzv_endpoint=10-0-10-160.default.pod.cluster.local:29500 --rdzv_id=colossalai-default-job /mnt/project/train.py --config /mnt/project/config.py --optimizer lars --synthetic --output /output/model

torchrun --nproc_per_node=1 --nnodes=2 --node_rank=1 --rdzv_backend=c10d --rdzv_endpoint=10-0-10-160.default.pod.cluster.local:29500 --rdzv_id=colossalai-default-job /mnt/project/train.py --config /mnt/project/config.py --optimizer lars --synthetic --output /output/model