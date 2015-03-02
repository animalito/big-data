# -*- coding: utf-8 -*-

import scrapy
from scrapy.http.request import Request

from nuforc.items import NuforcItem
import urlparse


class EventSpider(scrapy.Spider):
    name = 'event'
    allowed_domains = ['nuforc.org']
    start_urls = (
        'http://www.nuforc.org/webreports/ndxevent.html',
    )


    def parse(self, response):
        reports_urls = response.xpath('//*/td[1]/*/a[contains(@href, "ndxe")]')
        for link_selector in reports_urls:
            link = link_selector.xpath('@href').extract()[0]
            yield Request(urlparse.urljoin(response.url, link), callback=self.parse_reports)


    def parse_reports(self, response): 
        item_props = 'date_time,city,state,shape,duration,summary,posted'.split(',')
        for report in response.xpath('//table/tbody/tr'):
            #print '%s\n%s\n%s' % ('='*20, report.extract(), '*'*20)
            item = NuforcItem()
            data = report.xpath('.//td')
            try:
                link = data[0].xpath('.//a/@href').extract()[0]
                for idx, prop in enumerate(item_props):
                    value = data[idx].xpath('.//text()').extract()
                    item[prop] = value[0] if len(value) > 0 else 'NA'
            except Exception, err:
                print 'AARRGG %s' % err
            yield Request(urlparse.urljoin(response.url, link), meta={'item':item}, callback=self.parse_description)


    def parse_description(self, response):
        table_cells = response.xpath('//table/tbody/tr[2]/td//text()').extract()
        item = response.request.meta['item']
        item['report'] = ''.join(table_cells)
        print 'listo'
        yield item

