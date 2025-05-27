#!/bin/bash

cd terraform 

echo "Initializing Terraform..."

terraform apply -var-file="terraform.tfvars" -auto-approve

cd ../


echo "Generating SSH configuration file..."

./ssh-config.sh


echo "deploy.sh completed successfully."