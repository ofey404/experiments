#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# whoosh is abandoned. But I need a simple search engine here.
#
# https://whoosh.readthedocs.io/en/latest/quickstart.html
# https://mrchi.cc/posts/fulltext-search-by-whoosh-and-jieba/

mkdir -p indexdir
pip install whoosh jieba


python 1-starter.py 
# <Hit {'path': '/a', 'title': 'First document'}>

python 2-zh.py 
# 标题搜索，“更有趣的”
# <Hit {'path': '/b', 'title': '中文文档2，更有趣的'}>
# 内容搜索，“关键词1”
# <Hit {'path': '/a', 'title': '中文文档1'}>
