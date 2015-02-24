
# coding: utf-8

# In[1]:

import sys
import math
import re


# In[1]:

def main(doc):
     row=sys.stdin.readLine()
     contador=0
     print ("-")	
     while row:
        aux=0
        row=row.replace('~','').split()
        if "minunte" in row[2]:
           aux=1
        if "hour" in row[2]:
            aux=0.016667
        if "second" in row[2]:
            aux=60
        sal=aux*row[1]
        num+=sal
        mul+=row[1]*row[1]
        contador+=1
     for i in row:
	desv+=(row[1]-mean)**2
     print ("media" +num/contador+ "minutes")
     print ("desviacion estandar" +math.sqrt(desv)/contador)
    
        
        

