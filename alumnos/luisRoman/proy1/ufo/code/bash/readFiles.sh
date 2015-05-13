#!/usr/bin/bash
curl http://www.nuforc.org/webreports/ndxevent.html | grep -oE 'ndxe[0-9]{1,8}\.html' | while read line; do wget "http://www.nuforc.org/webreports/$line" ; done

