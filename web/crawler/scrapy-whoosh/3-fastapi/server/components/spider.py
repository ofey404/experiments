import scrapy
from whoosh.index import FileIndex

from config import CONFIG


class DocusaurusSpider(scrapy.Spider):
    name = "DocusaurusSpider"

    def __init__(self, index: FileIndex, *args, **kwargs):
        super(DocusaurusSpider, self).__init__(*args, **kwargs)
        self.ix = index
        self.page_counter = 0

    def parse(self, response):
        self.page_counter += 1
        writer = self.ix.writer()

        for article in response.css("div.theme-doc-markdown"):
            title = article.css("h1 ::text").get()
            link = response.css("a.pagination-nav__link--next ::attr(href)").get()
            content = "".join(article.css("::text").getall())
            writer.add_document(title=title, link=link, content=content)

        writer.commit()

        # follow first X pagination links
        if CONFIG.crawl_limit and self.page_counter < CONFIG.crawl_limit:
            for href in response.css("a.pagination-nav__link--next::attr(href)"):
                yield response.follow(href, self.parse)
