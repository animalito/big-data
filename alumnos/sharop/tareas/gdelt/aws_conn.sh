#!/usr/bin/env sh

#Extrae instancias en json
#aws ec2 describe-instances  >  instances.json
aws ec2 describe-instances \
| jq '.Reservations |.[]|.Instances|.[]|.InstanceId+"|"+.PublicDnsName'\
|sed 's/"//g'> instancias