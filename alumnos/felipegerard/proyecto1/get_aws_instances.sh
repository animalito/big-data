#!/usr/bin/env sh

# Extrae instancias en json
# Version original: sharop
# Modificaciones: FelipeGerard (mejor sin jq, usando sed)

aws ec2 describe-instances \
| sed -n -E '/ec2.+compute\.amazonaws\.com/s/(.+)(ec2.+compute.amazonaws.com)(.+)/\2/p' \
| uniq
