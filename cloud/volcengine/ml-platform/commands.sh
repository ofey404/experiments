#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# local run
python pytorch-official-example.py

##############################################
# Example code at [发起 PyTorchDDP 分布式训练](https://www.volcengine.com/docs/6459/75222)
##############################################
python -m torch.distributed.launch --nproc_per_node <单个实例上的进程数> --master_addr $MLP_WORKER_0_HOST --node_rank $MLP_ROLE_INDEX --master_port $MLP_WORKER_0_PORT --nnodes $MLP_WORKER_NUM <代码文件的绝对路径>

# 选择 CPU 实例规格时，nproc_per_node = 1，则代表每个实例上仅执行 1 个训练进程。
python -m torch.distributed.launch --nproc_per_node 1 --master_addr $MLP_WORKER_0_HOST --node_rank $MLP_ROLE_INDEX --master_port $MLP_WORKER_0_PORT --nnodes $MLP_WORKER_NUM <代码文件的绝对路径>

# 选择 GPU 实例规格时，通过环境变量配置每个实例上的训练进程数量与 GPU 数量一致。
python -m torch.distributed.launch --nproc_per_node $MLP_WORKER_GPU --master_addr $MLP_WORKER_0_HOST --node_rank $MLP_ROLE_INDEX --master_port $MLP_WORKER_0_PORT --nnodes $MLP_WORKER_NUM <代码文件的绝对路径>
##############################################

python -m torch.distributed.launch --nproc_per_node $MLP_WORKER_GPU --master_addr $MLP_WORKER_0_HOST --node_rank $MLP_ROLE_INDEX --master_port $MLP_WORKER_0_PORT --nnodes $MLP_WORKER_NUM pytorch-official-example-spmd.py
