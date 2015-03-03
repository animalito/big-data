#!/bin/bash

## Este script genera las instancias de AWS para bajar los datos
## --image-id ami-29ebb519: AMI con Ubuntu Server
## --count 3: 3 instancias
## --instance-type t2.micro: El tipo de maquina gratiuta
## --security-groups launch-wizard-1: Este grupo de seguridad tiene abierto el puerto 22 al mundo
## --key aws-akim: Par de llaves para la autenticacion
## --output json: Salida del comando en JSON para facilitar encontrar el ID de las nuevas maquinas

aws ec2 run-instances --image-id ami-29ebb519 --count 3 --instance-type t2.micro --security-groups launch-wizard-1 --key aws-akim --output json | python get_instances_id.py > instancias_aws.txt
