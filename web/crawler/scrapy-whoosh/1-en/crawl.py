import os
import scrapy

from whoosh.index import create_in
from whoosh.fields import *


class MySpider(scrapy.Spider):
    name = "myspider"

    start_urls = [
        os.environ.get(
            "URL", "https://easyops-cn.github.io/docusaurus-search-local/docs/"
        ),
    ]

    def __init__(self, *args, **kwargs):
        super(MySpider, self).__init__(*args, **kwargs)
        schema = Schema(title=TEXT(stored=True), link=ID(stored=True), content=TEXT)
        if not os.path.exists("indexdir"):
            os.mkdir("indexdir")
        self.ix = create_in("indexdir", schema)

    def parse(self, response):
        writer = self.ix.writer()

        for article in response.css("div.theme-doc-markdown"):
            title = article.css("header h1 ::text").get()
            link = response.css("a.pagination-nav__link--next ::attr(href)").get()
            content = "".join(article.css("::text").getall())
            print(f"title: {title}")
            print(f"link: {link}")
            print(f"content: {content}")
            writer.add_document(title=title, link=link, content=content)

        writer.commit()

        # follow pagination links
        for href in response.css("a.pagination-nav__link--next::attr(href)"):
            yield response.follow(href, self.parse)


from scrapy.crawler import CrawlerProcess
from scrapy.utils.project import get_project_settings

if __name__ == "__main__":
    process = CrawlerProcess(get_project_settings())
    process.crawl(MySpider)
    process.start()
