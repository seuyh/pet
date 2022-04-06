# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html
from pymongo import MongoClient
from scrapy import Request
from scrapy.pipelines.images import ImagesPipeline
from .settings import BOT_NAME

# useful for handling different item types with a single interface
from itemadapter import ItemAdapter


class AvitoParsePipeline:
    def process_item(self, item, spider):
        return item


class AvitoMongoPipeline:
    def __init__(self):
        client = MongoClient()
        self.db = client[BOT_NAME]

    def process_item(self, item, spider):
        self.db[spider.name].insert_one(item)
        return item
