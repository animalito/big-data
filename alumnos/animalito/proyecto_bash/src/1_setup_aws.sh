#!/bin/bash

echo

SOURCE="${BASH_SOURCE[0]}"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo Ejecutando $SOURCE
echo Carpeta de ejecución $DIR

n=4 
echo "Prendemos "${n}" maquinas"

aws ec2 run-instances --image-id ami-29ebb519 --count $n --instance-type t2.micro --key-name animalito --security-group-ids sg-d26c43b7 --associate-public-ip-address

aws ec2 describe-instances --query 'Reservations[*].Instances[*].PublicDnsName' --output text \
    | sed 's/\t/\n/g' | sed 's/ec2/ubuntu@ec2/g' > $DIR/../data/instancias.txt

