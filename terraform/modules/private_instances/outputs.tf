output "instance_ids" {
  description = "IDs of the created instances"
  value       = { for k, instance in aws_instance.private : k => instance.id }
}

output "private_ips" {
  description = "Private IPs of the instances"
  value       = { for k, instance in aws_instance.private : k => instance.private_ip }
}

output "jenkins_slave_private_ip" {
   
  description = "Private IP of the Jenkins slave instance"
  value       = aws_instance.jenkins_slave.private_ip
}