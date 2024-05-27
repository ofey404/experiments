import logging
import scrapy
from whoosh.index import FileIndex

from config import CONFIG

LOGGER = logging.getLogger(__name__)

class DocusaurusSpider(scrapy.Spider):
    name = "DocusaurusSpider"

    def __init__(self, idx: FileIndex, *args, **kwargs):
        super(DocusaurusSpider, self).__init__(*args, **kwargs)
        self.idx = idx
        self.page_counter = 0

    def parse(self, response):
        LOGGER.debug(f"Parsing URL {response.url}")
        LOGGER.debug(f"page_counter: {self.page_counter}")

        self.page_counter += 1
        writer = self.idx.writer()

        for article in response.css("div.theme-doc-markdown"):
            title = article.css("h1 ::text").get()
            link = response.urljoin(response.url)
            content = "".join(article.css("::text").getall())

            LOGGER.debug(f"title: {title}")
            LOGGER.debug(f"link: {link}")
            LOGGER.debug(f"content: {content}")
            writer.add_document(title=title, link=link, content=content)

        writer.commit()

        # follow first X pagination links
        if CONFIG.crawl_limit and self.page_counter < CONFIG.crawl_limit:
            for href in response.css("a.pagination-nav__link--next::attr(href)"):
                LOGGER.debug(f"follow next page: {href}")
                yield response.follow(href, self.parse)
