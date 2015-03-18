# -*- coding: utf-8 -*-

# Scrapy settings for nuforc project
#
# For simplicity, this file contains only the most important settings by
# default. All the other settings are documented here:
#
#     http://doc.scrapy.org/en/latest/topics/settings.html
#

BOT_NAME = 'nuforc'

SPIDER_MODULES = ['nuforc.spiders']
NEWSPIDER_MODULE = 'nuforc.spiders'

LOG_LEVEL = 'INFO'

FEED_EXPORTERS = {
    'csv': 'nuforc.exporters.DelimiterItemExporter',
}

CSV_DELIMITER = "|"

# Crawl responsibly by identifying yourself (and your website) on the user-agent
#USER_AGENT = 'nuforc (+http://www.yourdomain.com)'
