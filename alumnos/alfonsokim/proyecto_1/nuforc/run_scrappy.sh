#!/bin/bash

scrapy crawl event -o data.csv -t csv
mv data.csv ..
