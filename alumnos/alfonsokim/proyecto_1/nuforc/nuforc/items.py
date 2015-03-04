# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class NuforcItem(scrapy.Item):
    date_time = scrapy.Field()
    city = scrapy.Field()
    state = scrapy.Field()
    shape = scrapy.Field()
    duration = scrapy.Field()
    summary = scrapy.Field()
    report = scrapy.Field()
    posted = scrapy.Field()
