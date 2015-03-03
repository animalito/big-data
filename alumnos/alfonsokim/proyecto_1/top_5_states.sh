#!/bin/bash

cut -d$'|' -f3 data.csv | grep -Eo '[A-Z]{2}' | grep -Ev 'NA' | sort | uniq -c | sort -r | head -5
