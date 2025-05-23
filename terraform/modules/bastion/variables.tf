variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Public subnet ID to launch the bastion"
}

variable "security_group_id" {
  description = "Security group ID for the bastion"
}

variable "key_name" {
  description = "SSH key name for EC2 access"
}
