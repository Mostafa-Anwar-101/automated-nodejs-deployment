variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for ALB"
  type        = string
}

# variable "instance_private_ips" {
#   description = "Map of instance private IPs"
#   type        = map(string)
# }

variable "instance_ids" {
  description = "List of EC2 instance IDs to register with the ALB"
  type        = map(string)
}