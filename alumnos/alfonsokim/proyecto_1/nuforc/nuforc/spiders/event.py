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
        for report in response.xpath('//table/tbody/tr'):
            item = NuforcItem()
            data = report.xpath('.//td')
            try:
                link = data[0].xpath('.//a/@href').extract()[0]
                item['date_time'] = data[0].xpath('.//text()').extract()[0]
                item['city'] = data[1].xpath('.//text()').extract()[0]
                item['state'] = data[2].xpath('.//text()').extract()[0]
                item['shape'] = data[3].xpath('.//text()').extract()[0]
                item['duration'] = data[4].xpath('.//text()').extract()[0]
                item['summary'] = data[5].xpath('.//text()').extract()[0]
                item['posted'] = data[6].xpath('.//text()').extract()[0]
                yield Request(urlparse.urljoin(response.url, link), meta={'item':item}, callback=self.parse_description)
            except Exception, err:
                print 'AARRGG %s' % err.message
            return


    def parse_description(self, response):
        #print respose.body
        table_cells = response.xpath('//table/tbody/tr[2]/td//text()').extract()
        ##print 'el td: %s' % table_cells[1]
        item = response.request.meta['item']
        item['report'] = ''.join(table_cells)
        yield item

