#!/usr/bin/env sh

#Extraen de json los ssh formados en texto.
#Funciona para pruebas

aws ec2 describe-instances | jq '.Reservations |.[]|.Instances|.[]|.PublicDnsName'\
|sed 's/"//g' \
|awk '{print "ssh -i ~/.aws/dasci.pem ubuntu@"$1}'



