import logging
import os
from jieba.analyse import ChineseAnalyzer
from whoosh.fields import Schema, TEXT, ID
from whoosh.index import create_in, FileIndex
from server.components.spider import DocusaurusSpider
from config import CONFIG
from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

LOGGER = logging.getLogger(__name__)

SCHEMA = Schema(
    title=TEXT(stored=True, analyzer=ChineseAnalyzer()),
    link=ID(stored=True),
    content=TEXT(analyzer=ChineseAnalyzer()),
)


def create_index() -> FileIndex:
    d = CONFIG.index_dir
    if not os.path.exists(d):
        os.mkdir(d)
    LOGGER.debug(f"create index in dir {d}")
    idx = create_in(d, SCHEMA)
    process = CrawlerProcess(get_project_settings())
    process.crawl(DocusaurusSpider, idx=idx, start_urls=[CONFIG.crawl_start_url])
    process.start()  # the script will block here until the crawling is finished

    LOGGER.debug(f"parsed {idx.doc_count_all()} pages")