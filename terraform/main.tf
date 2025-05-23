provider "aws" {
  region = "us-east-1"
}
# ----------------------------------------------------------

#                     VPC module

# ----------------------------------------------------------


module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnets = {
    public-1 = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-1a"
    }
    public-2 = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-1b"
    }
  }

  private_subnets = {
    private-1 = {
      cidr_block = "10.0.3.0/24"
      az         = "us-east-1a"
    }
    private-2 = {
      cidr_block = "10.0.4.0/24"
      az         = "us-east-1b"
    }
  }
  project_name         = var.project_name
}

# ----------------------------------------------------------

#                     Security_Groups module

# ----------------------------------------------------------

module "security_groups" {
  source      = "./modules/security_groups"
  vpc_id      = module.vpc.vpc_id
}

# ----------------------------------------------------------

#                     Bastion module

# ----------------------------------------------------------

module "bastion" {
  source            = "./modules/bastion"
  ami_id            = var.ami_id
  instance_type     = var.bastion_instance_type
  subnet_id         = module.vpc.public_subnet_ids_list[1]
  security_group_id = module.security_groups.bastion_sg_id
  key_name          = var.key_pair_name
  project_name      = var.project_name
}

# ----------------------------------------------------------

#                     Jenkins_Agent module

# ----------------------------------------------------------

module "private_instances" {
  source           = "./modules/private_instances"
  ami_id           = var.ami_id
  instance_type    = var.private_instance_type
  project_name     = var.project_name
  private_subnets  = {
    "private-1"    = {
      subnet_id    = module.vpc.private_subnet_ids_list[0]
    },
    "private-2"    = {
      subnet_id    = module.vpc.private_subnet_ids_list[1]
    }
  }
  security_group_id = module.security_groups.private_instances_sg_id
  key_name          = var.key_pair_name
}

# ----------------------------------------------------------

#                     ALB module

# ----------------------------------------------------------

module "alb" {
  source = "./modules/alb"

  vpc_id             = module.vpc.vpc_id
  alb_sg_id          = module.security_groups.alb_sg_ID
  public_subnet_ids  = module.vpc.public_subnet_ids_list
  instance_ids       = module.private_instances.instance_ids
  project_name       = var.project_name
}