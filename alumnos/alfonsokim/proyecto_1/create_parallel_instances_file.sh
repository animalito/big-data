#!/bin/bash

## Llama al comando describe-instances e invoca al script de python que formatea el archivo de autenticacion de parallel

aws ec2 describe-instances --instance-ids `cat instancias_aws.txt` --output json | python get_public_ip.py > slf_instancias_aws.txt
