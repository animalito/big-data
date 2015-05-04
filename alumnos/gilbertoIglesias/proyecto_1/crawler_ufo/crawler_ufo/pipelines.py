# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

from pymongo import MongoClient
import json
from scrapy.conf import settings

class CrawlerUfoPipeline(object):

    connection = MongoClient('localhost', 27017)

    def process_item(self, item, spider):
        print "Insercion final"
        db = self.connection.ufos.observaciones
        item_dict = dict(item)
        db.insert(item_dict)
        return item
