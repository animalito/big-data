#!/usr/bin/env python

# Parsea la respuesta del describe-instances de AWS CLI y encuentra la direccion IP publica de la instancia
# Ademas formatea la salida para la conexion SSL de parallel

import sys, json

for ip in [i['PublicIpAddress'] for i in json.load(sys.stdin)['Reservations'][0]['Instances']]:
    print 'ssh ubuntu@%s -i ~/aws/iam_alfonsokim/aws-akim.pem' % ip