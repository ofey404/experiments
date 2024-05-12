import scrapy
from scrapy_splash import SplashRequest



class ScrapingClubSpider(scrapy.Spider):
    name = "scraping_club"
    allowed_domains = ["scrapingclub.com"]
    start_urls = ["http://scrapingclub.com/"]

    def parse(self, response):
        # iterate over the product elements
        for product in response.css(".post"):
            url = product.css("a").attrib["href"]
            image = product.css(".card-img-top").attrib["src"]
            name = product.css("h4 a::text").get()
            price = product.css("h5::text").get()
        
                # add scraped product data to the list
                # of scraped items
        
            yield {
                "url": url,
                "image": image,
                "name": name,
                "price": price
            }


    def start_requests(self):
        url = "https://scrapingclub.com/exercise/list_infinite_scroll/"
        yield SplashRequest(url, callback=self.parse)
