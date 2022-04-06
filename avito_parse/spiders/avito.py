import scrapy
from time import sleep
from avito_parse.spiders.xpath import xpath_selectors, xpath_ad_selectors
from avito_parse.loaders import AvitoLoader
from scrapy.item import Item, Field
from scrapy.http import Request, FormRequest


def authentication_failed(response):
    pass


class LoginSpider(scrapy.Spider):
    name = 'avito.ru'
    start_urls = ['https://www.avito.ru/#login?authsrc=h']

    def parse(self, response, *args, **kwargs):
        return scrapy.FormRequest.from_response(
            response,
            formdata={'login': '+79782408755', 'password': 'Alessnss1'},
            callback=self.after_login
        )

    def after_login(self, response):
        if authentication_failed(response):
            self.logger.error("Login failed")
            return


class AvitoSpider(scrapy.Spider):
    name = "avito"
    allowed_domains = ["avito.ru"]
    start_urls = ["https://www.avito.ru/novosibirsk/nedvizhimost?district=806&user=1"]

    def _get_xpath(self, response, xpath, callback):
        for url in response.xpath(xpath):
            yield response.follow(url, callback=callback)

    def parse(self, response, *args, **kwargs):
        yield from self._get_xpath(response, xpath_selectors["pagination_url"], self.parse)
        yield from self._get_xpath(response, xpath_selectors["advert"], self.advert_parse)

    def advert_parse(self, response):
        loader = AvitoLoader(response=response)
        loader.add_value("url", response.url)
        for key, xpath in xpath_ad_selectors.items():
            loader.add_xpath(key, xpath)
        yield scrapy.Request("https://www.avito.ru/web/1/items/phone/" + response.url[-10:], callback=self.phone_parse,
                             meta={"loader": loader})

    def phone_parse(self, response):
        loader = response.meta["loader"]
        loader.add_value("phone", response.text)
        yield loader.load_item()
