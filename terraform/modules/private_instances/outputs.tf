output "instance_ids" {
  description = "IDs of the created instances"
  value       = { for k, instance in aws_instance.private : k => instance.id }
}

output "private_ips" {
  description = "Private IPs of the instances"
  value       = { for k, instance in aws_instance.private : k => instance.private_ip }
}