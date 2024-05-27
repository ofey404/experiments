import os
import scrapy

from whoosh.index import create_in
from whoosh.fields import *
import jieba
from jieba.analyse import ChineseAnalyzer

jieba.initialize()


class MySpider(scrapy.Spider):
    name = "myspider"

    start_urls = [
        os.environ.get(
            "URL", "https://docusaurus.io/zh-CN/docs/category/getting-started"
        ),
    ]

    def __init__(self, *args, **kwargs):
        super(MySpider, self).__init__(*args, **kwargs)
        schema = Schema(
            title=TEXT(stored=True, analyzer=ChineseAnalyzer()),
            link=ID(stored=True),
            content=TEXT(analyzer=ChineseAnalyzer()),
        )
        if not os.path.exists("indexdir"):
            os.mkdir("indexdir")
        self.ix = create_in("indexdir", schema)
        self.page_counter = 0

    def parse(self, response):
        self.page_counter += 1
        writer = self.ix.writer()

        for article in response.css("div.theme-doc-markdown"):
            title = article.css("h1 ::text").get()
            link = response.css("a.pagination-nav__link--next ::attr(href)").get()
            content = "".join(article.css("::text").getall())
            print(f"title: {title}")
            print(f"link: {link}")
            print(f"content: {content}")
            writer.add_document(title=title, link=link, content=content)

        writer.commit()

        # follow first 5 pagination links
        if self.page_counter < 5:
            for href in response.css("a.pagination-nav__link--next::attr(href)"):
                yield response.follow(href, self.parse)


from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

if __name__ == "__main__":
    process = CrawlerProcess(get_project_settings())
    process.crawl(MySpider)
    process.start()  # the script will block here until the crawling is finished
