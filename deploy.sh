#!/bin/bash

echo "📦 Initializing Terraform..."
cd terraform 
terraform apply -var-file="terraform.tfvars" -auto-approve

echo "📤 Extracting Terraform outputs..."
echo "Generating SSH configuration file..."
cd ../
./ssh-config.sh


echo "🚀 Running Ansible playbook..."
cd ../ansible
ansible-playbook -i inventory jenkins-slave-plybook.yaml


echo "🔁 Enable port forwarding on Bastion Host ..."
ssh bastion <<EOF
  sudo sed -i '/^GatewayPorts/d;/^AllowTcpForwarding/d' /etc/ssh/sshd_config
  echo "GatewayPorts yes" | sudo tee -a /etc/ssh/sshd_config
  echo "AllowTcpForwarding yes" | sudo tee -a /etc/ssh/sshd_config
  sudo systemctl restart sshd
EOF

echo "🔁 Starting reverse SSH tunnel from local to Bastion Host..."
ssh -i ~/.ssh/automated-nodejs-key.pem -o "ExitOnForwardFailure=yes" -f -N -R 8080:localhost:8080 bastion

echo "✅ All done!"