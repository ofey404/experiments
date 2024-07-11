#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# CDN 防盗刷

# 防火防盗防CDN流量盗刷
# https://www.cnblogs.com/xiezhr/p/18293093

# 下面来说下遇到这样的情况，应该怎么处理
# 
# ① 一定要设置流量告警监控
# 
# 不管你用的是哪个厂商的云存储，cdn服务，都要设置一个流量阈值（这个根据自己网站访问量来设置），超过阈值，短信或者邮件提醒
# 
# ② 个人网站静态资源，能压缩尽量压缩了再放上去，大文件分分钟就把你薅没了
# 
# ③ 查出高频IP，立马拉进小黑屋
# 
# ④ 开启防盗链
# 
# ⑤ 如果在电脑旁边，立马把cdn加速服务关闭了
# 
# ⑥ 设置访问频率
# 
# ⑦ 设置欠费停止服务
# 
# 个人的cdn服务默认设置的是隔天扣费，改成按小时付费，欠费即停止服务


# 盗链行为与 AWS 防盗链技术
# https://aws.amazon.com/cn/blogs/china/hotlinking-behavior-and-aws-anti-hotlinking-technology/
