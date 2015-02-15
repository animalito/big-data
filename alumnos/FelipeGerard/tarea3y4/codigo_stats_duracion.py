#!/usr/bin/env python

import re
import sys

#n = int(sys.argv[1]) # Leemos un entero como argumento
texto = sys.stdin.readline()  # Leemos texto desde el stdin

n = 0
suma = 0
sumsq = 0
while texto != '' or n < 10:
    texto = sys.stdin.readline()  # Leemos texto desde el stdin
    if texto != '':
        dur = texto.split('\t')[4]
        dur2 = re.sub('([^0-9]*)', '', dur, 1)
        if dur2 != '' and re.search('[~+:/\.@]', dur2) == None and re.search('seg|sec|min|hour|hr', dur2):
            num = -1
            if re.search('[0-9]+\-[0-9]+', dur2):
                nums = re.sub('([0-9]+\-[0-9]+)(.*)', '\g<1>', dur2, 1)
                nums = [float(i) for i in nums.split('-')]
                num = sum(nums)/len(nums)
            elif re.search('\-', dur2) == None:
                num = float(re.sub('([0-9]+)(.*)', '\g<1>', dur2))
            if num != -1:
                if re.search('min', dur2):
                    num = num*60
                elif re.search('hour', dur2):
                    num = num*3600
                n = n + 1
                suma = suma + num
                sumsq = sumsq + num*num

media = suma/n
meansq = sumsq/n
varianza = meansq - media*media

print 'n = ', n
print 'suma = ', suma
print 'media = ', media
print 'varianza = ', varianza
