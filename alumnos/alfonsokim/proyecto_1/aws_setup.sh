#!/bin/bash

parallel --nonall --slf slf_instancias_aws.txt "yes | sudo apt-get update && yes | sudo-apt-get install parallel && sudo apt-get install python-dev build-essential python-scrapy"
