#!/usr/bin/env python

# Este script parsea el JSON de salida del comando de generacion de instancias en AWS
# y encuentra los ids de de las instancias recien creadas

import sys, json

print ' '.join([i['InstanceId'] for i in json.load(sys.stdin)['Instances']])