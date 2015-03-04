#!/usr/bin/env python

import re
import sys
import math
from pymongo import MongoClient
from datetime import datetime, timedelta
import time

def limpia_duracion(duracion):
	res = False

connection = MongoClient("localhost", 27017)
mongo_db = connection.ufos.observaciones
elem_final = []


if sys.argv[1] == "conteo_global":
	count = mongo_db.count()
      	print count
elif sys.argv[1] == "top_5_estados":
	for obs in mongo_db.find( { "state" : { "$ne" : ""} }, { "state": 1 } ):
		print obs["state"]
elif sys.argv[1] == "top_5_estados_x_anio":
	anio = sys.argv[2]
	regex = "^[0-9]+/[0-9]+/" + anio[2:] + "\ .*"
	for obs in mongo_db.find( { "date_text" : { "$regex" : regex }, "state" : { "$ne" : ""} }, { "state": 1 } ):
		print obs["state"]
elif sys.argv[1] == "racha_larga_estado":
	date_final = ""
	date_inicial = datetime.strptime("1/1/1000", "%d/%m/%Y")
	for obs in mongo_db.find( { "state" : sys.argv[2], "date_text" : { "$ne" : ""} }, { "date_text": 1 } ):
		fecha_temp = obs["date_text"].split()
		date_final = datetime.strptime(fecha_temp[0], "%m/%d/%y")
		dias = date_final - date_inicial
		print dias.days
elif sys.argv[1] == "racha_larga_pais":
	date_final = ""
	date_inicial = datetime.strptime("1/1/1000", "%d/%m/%Y")
	for obs in mongo_db.find( { "date_text" : { "$ne" : ""} }, { "date_text": 1 } ):
		fecha_temp = obs["date_text"].split()
		date_final = datetime.strptime(fecha_temp[0], "%m/%d/%y")
		dias = date_final - date_inicial
		print dias.days
elif sys.argv[1] == "mes_mas_avistamientos":
	for obs in mongo_db.find( { "date_text" : { "$ne" : ""} }, { "date_text": 1 } ):
		fecha_temp = obs["date_text"].split()
		print int(datetime.strptime(fecha_temp[0], "%m/%d/%y").strftime("%m") )
elif sys.argv[1] == "dia_mas_avistamientos":
	for obs in mongo_db.find( { "date_text" : { "$ne" : ""} }, { "date_text": 1 } ):
		fecha_temp = obs["date_text"].split()
		print int(datetime.strptime(fecha_temp[0], "%m/%d/%y").weekday() )
elif sys.argv[1] == "dias_observaciones_completo":
	for obs in mongo_db.find( { "date_text" : { "$ne" : ""} }, { "date_text": 1 } ):
		fecha_temp = obs["date_text"].split()
		res = int(datetime.strptime(fecha_temp[0], "%m/%d/%y").strftime("%Y%m%d"))
		if res > 20091231 and res < 20151231:
			print res
elif sys.argv[1] == "dias_observaciones_estado":
	for obs in mongo_db.find( { "state" : sys.argv[2], "date_text" : { "$ne" : ""} }, { "date_text": 1 } ):
		fecha_temp = obs["date_text"].split()
		res = int(datetime.strptime(fecha_temp[0], "%m/%d/%y").strftime("%Y%m%d"))
		if res < 20151231:
			print res
elif sys.argv[1] == "cuenta_racha":
	var = True
	linea = sys.stdin.readline()
	menor_global = int(linea)
	mayor_global = menor_global
	menor_temp = menor_global
	mayor_temp = menor_global
	cuenta_mas_larga_global = 1
	cuenta_mas_larga_temp = 1
	while linea != "" and var == True:
		try:
			num = int(sys.stdin.readline())
			if num == mayor_temp + 1:
				cuenta_mas_larga_temp += 1
				mayor_temp = num
			else: 
				if (cuenta_mas_larga_temp > cuenta_mas_larga_global):
					menor_global = menor_temp
					mayor_global = mayor_temp
					cuenta_mas_larga_global = cuenta_mas_larga_temp
				menor_temp = num
				mayor_temp = num
				cuenta_mas_larga_temp = 1
		except:
			var = False
	print "La racha mas larga es de " + str(cuenta_mas_larga_global) + " dias"
	print "Consecutivo menor: " + str(menor_global)
	#res = datetime.fromtimestamp(menor_global * 1000) #+ timedelta(days = 14192) 
	#print res.strftime("%d/%m/%Y")
	print "Consecutivo mayor: " + str(mayor_global )
	#res = datetime.fromtimestamp(mayor_global * 1000) #+ timedelta(days = 14192)
	#print res.strftime("%d/%m/%Y")
	print ""
