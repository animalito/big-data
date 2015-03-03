#!/bin/bash

aws ec2 run-instances --image-id ami-29ebb519 --count 3 --instance-type t2.micro --security-groups launch-wizard-1 --key aws-akim --output json | python get_instances_id.py > instancias_aws.txt
