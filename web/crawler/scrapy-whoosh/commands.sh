#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

mkdir -p indexdir
pip install scrapy whoosh jieba

#####################################################################
# 1. English site map
#####################################################################

cd 1-en/
python crawl.py 
python print-index.py
# ix.doc_count_all() = 4
# <Hit {'link': '/docusaurus-search-local/docs/doc2', 'title': 'Style Guide'}>
# <Hit {'link': '/docusaurus-search-local/docs/doc3', 'title': 'Document Number 2'}>
# <Hit {'link': '/docusaurus-search-local/docs/mdx', 'title': 'This is Document Number 3'}>
# <Hit {'title': 'Powered by MDX'}>

#####################################################################
# 2. Chinese full text search
#####################################################################

cd 2-zh/
python crawl.py 
python print-index.py
python search.py 
# 标题搜索，“安装流程”
# <Top 0 Results for And([Term('title', '安装'), Term('title', '流程')]) runtime=0.00010666300113371108>
# 内容搜索，“配置文件”
# <Top 0 Results for And([Term('content', '配置'), Term('content', '文件'), Term('content', '配置文件')]) runtime=5.9611000324366614e-05>

#####################################################################
# 3. FastAPI
#####################################################################

cd 3-fastapi/
python main.py
# then visit /search/
