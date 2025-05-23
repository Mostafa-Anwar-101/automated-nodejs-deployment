variable "project_name" {
  default = "automated-deplyment"
  
}
# ----------------------------------------------------------

#                     VPC module

# ----------------------------------------------------------

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  default = "us-east-1a"
}


# ----------------------------------------------------------

#                     Bastion module

# ----------------------------------------------------------


variable "ami_id" {
  default = "ami-0fc5d935ebf8bc3bc"  # Ubuntu (us-east-1)
}

variable "key_pair_name" {
  description = "AWS EC2 Key Pair name"
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "allowed_ssh_cidr" {
  default = "0.0.0.0/0"
}

# ----------------------------------------------------------

#                     Jenkins_Agent module

# ----------------------------------------------------------
variable "private_instance_type" {
  default = "t2.micro"
}