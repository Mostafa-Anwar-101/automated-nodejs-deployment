variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for Jenkins agent"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Jenkins agent"
  type        = string
  default     = "t2.micro"
}

variable "private_subnets" {
  description = "Map of private subnets with their IDs"
  type        = map(object({
    subnet_id = string
  }))
}
variable "security_group_id" {
  description = "Security group for Jenkins agent"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
}
