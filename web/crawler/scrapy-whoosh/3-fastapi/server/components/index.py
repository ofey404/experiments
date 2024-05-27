import os
from jieba.analyse import ChineseAnalyzer
from whoosh.fields import Schema, TEXT, ID
from whoosh.index import create_in, FileIndex
from config import CONFIG

SCHEMA = Schema(
    title=TEXT(stored=True, analyzer=ChineseAnalyzer()),
    link=ID(stored=True),
    content=TEXT(analyzer=ChineseAnalyzer()),
)


def create_index() -> FileIndex:
    d = CONFIG.index_dir
    if not os.path.exists(d):
        os.mkdir(d)
    return create_in(d, SCHEMA)
