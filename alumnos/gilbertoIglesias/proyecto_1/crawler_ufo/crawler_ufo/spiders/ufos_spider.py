import scrapy
import pprint
from datetime import datetime

from scrapy.http import FormRequest
from scrapy.http import Request
from scrapy.spider import BaseSpider
import xml.etree.ElementTree as ET
from lxml import etree as ltree
from lxml import html as lhtml
import re
from urlparse import urljoin
from scrapy.http import HtmlResponse
from crawler_ufo.items import CrawlerUfoItem,Crawler_2Item,Crawler_3Item

class UFOSSpider(scrapy.Spider):
    name = "crawler_ufo"
    cadena_temp_1 = ""
    url_nuevo = ""
    allowed_domains = ["http://nuforc.org/webreports/ndxevent.html*"]

    def parse_3(self, response, item):
       cadena_temp_2 = response.body.lower().replace("<p>","")
       response = HtmlResponse(url=response.url, body=cadena_temp_2)
       #pprint.pprint(response.xpath('.//body/table/font/caption/b/text()').extract()[0])
       #pprint.pprint("******************************")
       pprint.pprint(item)
       for registro in response.xpath('.//body/table/tbody'):
           if not registro.xpath('tr[1]/td/font').extract():
               item["detalle1"] = ""
           else:
               item["detalle1"] = registro.xpath('tr[1]/td/font').extract()[0]
           if not registro.xpath('tr[2]/td/font').extract():
               item["detalle2"] = ""
           else:
               item["detalle2"] = registro.xpath('tr[2]/td/font').extract()[0]
           #pprint.pprint(item_tabla_3)
           yield item
           #yield item_tabla_3
           
       #pprint.pprint("******************************")

    def parse_2(self, response):
       cadena_temp_1 = response.body.split("<TABLE  CELLSPACING=1>")
       cadena_temp_1 = cadena_temp_1[1].split("</TABLE>")
       cadena_temp_1[0] = ('<HTML><BODY><TABLE  CELLSPACING=1>' + cadena_temp_1[0] + '</TABLE></BODY></HTML>').lower()
       response = HtmlResponse(url=response.url, body=cadena_temp_1[0])
       #pprint.pprint("++++++++++++++++++++++++++++++")
       for registro in response.xpath('.//body/table/tbody/tr'):
           item = Crawler_2Item()
           if not registro.xpath('td[1]/font/a/text()').extract():
               item["date_text"] = ""
           else:
               item["date_text"] = registro.xpath('td[1]/font/a/text()').extract()[0]
           if not registro.xpath('td[1]/font/a/@href').extract():
               item["date_href"] = ""
           else:
               item["date_href"] = registro.xpath('td[1]/font/a/@href').extract()[0]
           if not registro.xpath('td[2]/font/text()').extract():
               item["city"] = ""
           else:
               item["city"] = registro.xpath('td[2]/font/text()').extract()[0]
           if not registro.xpath('td[3]/font/text()').extract():
               item["state"] = ""
           else:
               item["state"] = registro.xpath('td[3]/font/text()').extract()[0]
           if not registro.xpath('td[4]/font/text()').extract():
               item["shape"] = ""
           else:
               item["shape"] = registro.xpath('td[4]/font/text()').extract()[0]
           if not registro.xpath('td[5]/font/text()').extract():
               item["duration"] = ""
           else:
               item["duration"] = registro.xpath('td[5]/font/text()').extract()[0]
           if not registro.xpath('td[6]/font/text()').extract():
               item["summary"] = ""
           else:
               item["summary"] = registro.xpath('td[6]/font/text()').extract()[0]
           if not registro.xpath('td[7]/font/text()').extract():
               item["posted"] = ""
           else:
               item["posted"] = registro.xpath('td[7]/font/text()').extract()[0]
           #pprint.pprint(item_tabla_2) 
           url_nuevo =	'http://nuforc.org/webreports/' + item["date_href"]
           item["detalle1"] = ""
           item["detalle2"] = ""
           yield scrapy.Request(url_nuevo , body = "", method = 'GET', headers={"content-type":"application/x-www-form-urlencoded"}, dont_filter = True, callback = lambda r : self.parse_3(r, item) )
       #pprint.pprint("++++++++++++++++++++++++++++++")

    def parse(self, response):
       #pprint.pprint("------------------------------")
       cadena_temp_1 = response.body.split("<TABLE  CELLSPACING=1>")
       cadena_temp_1 = cadena_temp_1[1].split("</TABLE>")
       cadena_temp_1[0] = '<HTML><BODY><TABLE  CELLSPACING=1>'.lower() + cadena_temp_1[0].lower() + '</TABLE></BODY></HTML>'.lower()
       response_2 = HtmlResponse(url="http://nuforc.org/webreports/ndxevent.html", body=cadena_temp_1[0])
       for registro in response_2.xpath('.//body/table/tbody/tr'):
            item_tabla = CrawlerUfoItem()
            item_tabla['report_href'] = registro.xpath('td[1]/font/a/@href').extract()[0]
            item_tabla['report_text'] = registro.xpath('td[1]/font/a/text()').extract()[0]
            item_tabla['count'] = registro.xpath('td[2]/font/text()').extract()[0]
            #pprint.pprint(item_tabla)
            url_nuevo =	'http://nuforc.org/webreports/' + item_tabla['report_href']
            yield scrapy.Request(url_nuevo, body = "", method = 'GET', headers={"content-type":"application/x-www-form-urlencoded"}, callback = self.parse_2, dont_filter = True)
       #pprint.pprint("------------------------------")

    def __init__(self, category=None, *args, **kwargs):
       super(UFOSSpider, self).__init__(*args, **kwargs)
       self.start_urls.append("http://nuforc.org/webreports/ndxevent.html")

