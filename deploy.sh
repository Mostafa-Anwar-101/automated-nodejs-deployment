#!/bin/bash

cd terraform 

terraform apply -var-file="terraform.tfvars" -auto-approve

cd ../

./ssh-config.sh