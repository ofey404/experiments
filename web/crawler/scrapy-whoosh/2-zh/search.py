from pprint import pprint
from whoosh.index import create_in
from whoosh.fields import *
from whoosh.qparser import QueryParser
import jieba
from jieba.analyse import ChineseAnalyzer

jieba.initialize()


schema = Schema(
    title=TEXT(stored=True, analyzer=ChineseAnalyzer()),
    link=ID(stored=True),
    content=TEXT(analyzer=ChineseAnalyzer()),
)
ix = create_in("indexdir", schema)

with ix.searcher() as searcher:
    print("标题搜索，“安装流程”")
    query = QueryParser("title", ix.schema).parse("安装流程")
    results = searcher.search(query)
    pprint(results)

    print("内容搜索，“配置文件”")
    query = QueryParser("content", ix.schema).parse("配置文件")
    results = searcher.search(query)
    pprint(results)
