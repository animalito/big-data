#!/bin/bash

aws ec2 describe-instances --instance-ids `cat instancias_aws.txt` --output json | python get_public_ip.py > slf_instancias_aws.txt
