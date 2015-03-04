# -*- coding: utf-8 -*-

# Scrapy settings for crawler_ufo project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'crawler_ufo'

SPIDER_MODULES = ['crawler_ufo.spiders']
NEWSPIDER_MODULE = 'crawler_ufo.spiders'

ITEM_PIPELINES = {'crawler_ufo.pipelines.CrawlerUfoPipeline' : 300,}
# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'crawler_ufo (+http://www.yourdomain.com)'
