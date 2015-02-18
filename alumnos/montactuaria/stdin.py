#!/usr/bin/env python

import re
import sys

while True:
  linea = sys.stdin.readline()

  if not linea:
    break

  linea = re.sub("minutes","m",linea,flags=re.IGNORECASE)
  linea = re.sub("minute","m",linea,flags=re.IGNORECASE)
  linea = re.sub("min","m",linea,flags=re.IGNORECASE)
  linea = re.sub("mi","m",linea,flags=re.IGNORECASE)
  linea = re.sub("seconds","s",linea,flags=re.IGNORECASE)
  linea = re.sub("second","s",linea,flags=re.IGNORECASE)
  linea = re.sub("sec","s",linea,flags=re.IGNORECASE)
  linea = re.sub("hours","h",linea,flags=re.IGNORECASE)
  linea = re.sub("hour","h",linea,flags=re.IGNORECASE)
  linea = re.sub("~", "", linea)
  linea = re.sub(r"[^msh0-9]", "", linea)
  print linea
