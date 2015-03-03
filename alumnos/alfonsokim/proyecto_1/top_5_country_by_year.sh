#!/bin/bash

cut -d$'|' -f1,3 data.csv | awk -f states_by_year.awk | sort -t "|" -k 1,1 -k 2,2 | uniq -c | sort -r 