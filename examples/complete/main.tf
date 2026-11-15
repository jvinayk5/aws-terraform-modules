terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  description = "AWS region."
  type        = string
  default     = "ap-south-1"
}

variable "name" {
  description = "Name prefix for all resources."
  type        = string
  default     = "demo"
}

variable "enable_nat_gateway" {
  description = "Create a NAT gateway (billed hourly)."
  type        = bool
  default     = false
}

variable "create_database" {
  description = "Create the RDS instance (billed hourly)."
  type        = bool
  default     = false
}

locals {
  azs  = ["${var.region}a", "${var.region}b"]
  tags = { Project = var.name, ManagedBy = "terraform" }
}

module "vpc" {
  source = "../../modules/vpc"

  name                 = var.name
  azs                  = local.azs
  public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = local.tags
}

module "ecr" {
  source = "../../modules/ecr"

  name = "${var.name}-app"
  tags = local.tags
}

module "artifacts" {
  source = "../../modules/s3"

  bucket_name   = "${var.name}-artifacts-${data.aws_caller_identity.current.account_id}"
  force_destroy = true
  tags          = local.tags
}

module "alb" {
  source = "../../modules/alb"

  name       = var.name
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  tags       = local.tags
}

module "database" {
  source = "../../modules/rds"
  count  = var.create_database ? 1 : 0

  name                       = "${var.name}-db"
  vpc_id                     = module.vpc.vpc_id
  subnet_ids                 = module.vpc.private_subnet_ids
  allowed_security_group_ids = [module.alb.security_group_id]
  deletion_protection        = false
  skip_final_snapshot        = true
  tags                       = local.tags
}

data "aws_caller_identity" "current" {}

output "alb_dns_name" {
  description = "Public DNS name of the load balancer."
  value       = module.alb.dns_name
}

output "ecr_repository_url" {
  description = "Where to push images."
  value       = module.ecr.repository_url
}
