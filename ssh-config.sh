#!/bin/bash

cd terraform
terraform output -json > ../terraform_output.json
terraform_output_file="../terraform_output.json"


bastion_ip=$(jq -r '.["bastion_public_ip"].value' "$terraform_output_file")

slave_ip=$(jq -r '.["jenkins_slave_private_ip"].value' "$terraform_output_file")

private_1_ip=$(jq -r '.["private_instance_1_private_ip"].value' "$terraform_output_file")

private_2_ip=$(jq -r '.["private_instances_2_private_ip"].value' "$terraform_output_file")


SSH_CONFIG="$HOME/.ssh/config"


echo "
Host bastion
    HostName $bastion_ip
    User ubuntu
    IdentityFile ~/.ssh/automated-nodejs-key.pem
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

Host jenkins-slave
    HostName $slave_ip
    User ubuntu
    IdentityFile ~/.ssh/automated-nodejs-key.pem
    ProxyJump bastion
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

Host private-instance-1
    HostName $private_1_ip
    User ubuntu
    IdentityFile ~/.ssh/automated-nodejs-key.pem
    ProxyJump bastion
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

Host private-instance-2
    HostName $private_2_ip
    User ubuntu
    IdentityFile ~/.ssh/automated-nodejs-key.pem
    ProxyJump bastion
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
" >"$SSH_CONFIG"
