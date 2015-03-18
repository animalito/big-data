#!/bin/bash

## Flujo para crear, levantar y aprovisionar las instancias de AWS

./create_aws_instances.sh
./create_parallel_instances_file.sh
./aws_setup.sh
