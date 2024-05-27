from whoosh.index import create_in
from whoosh.fields import *
import jieba
from jieba.analyse import ChineseAnalyzer

jieba.initialize()


schema = Schema(
    title=TEXT(stored=True, analyzer=ChineseAnalyzer()),
    path=ID(stored=True),
    content=TEXT,
)
ix = create_in("indexdir", schema)
writer = ix.writer()
writer.add_document(
    title="中文文档1", path="/a", content="这是我们添加的第一个文档。关键词1"
)
writer.add_document(
    title="中文文档2，更有趣的",
    path="/b",
    content="这是文档 2，比文档 1 更有趣。关键词2",
)
writer.commit()

from whoosh.qparser import QueryParser

with ix.searcher() as searcher:
    print("标题搜索，“更有趣的”")
    query = QueryParser("title", ix.schema).parse("更有趣的")
    results = searcher.search(query)
    print(results[0])

    print("内容搜索，“关键词1”")
    query = QueryParser("content", ix.schema).parse("关键词1")
    results = searcher.search(query)
    print(results[0])