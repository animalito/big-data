#!/bin/bash
curl -s http://www.gutenberg.org/cache/epub/35/pg35.txt \
     | tr '[:upper:]' '[:lower:]' \
     | tr -s '[[:punct:][:space:]]' '\n' \
     | sort \
     | uniq -c \
     | sort -r -t $'\t' \
     | head
