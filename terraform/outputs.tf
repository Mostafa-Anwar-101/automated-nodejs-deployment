# ----------------------------------------------------------

#                     VPC outputs

# ----------------------------------------------------------

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "nat_gateway_public_ip" {
  value = module.vpc.aws_nat_gateway_id
}

# ----------------------------------------------------------

#                     Bastion outputs

# ----------------------------------------------------------

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

# ----------------------------------------------------------

#               private_instances_private outputs

# ----------------------------------------------------------

output "private_instance_1_private_ip" {
  value = module.private_instances.private_ips["private-1"]
}

output "private_instances_2_private_ip" {
  value = module.private_instances.private_ips["private-2"]
}

output "jenkins_slave_private_ip" {
  value = module.private_instances.jenkins_slave_private_ip
  
}
# ----------------------------------------------------------

#                    ALB outputs

# ----------------------------------------------------------

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}