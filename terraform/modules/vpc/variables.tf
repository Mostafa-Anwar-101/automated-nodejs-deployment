# variable "vpc_cidr" {}
# variable "public_subnet_cidr" {}
# variable "private_subnet_cidr" {}
# variable "availability_zone" {}
# variable "project_name" {
#   type = string
# }


variable "project_name" {
  description = "Prefix for all resource names"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "Map of public subnets with AZ and CIDR"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "private_subnets" {
  description = "Map of private subnets with AZ and CIDR"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}