output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}

output "private_instances_sg_id" {
  value = aws_security_group.agent_sg.id
}

output "alb_sg_ID" {
  value = aws_security_group.alb_sg.id
}
