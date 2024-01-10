terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    bucket         = "app-s3-bucket-tfstate"
    key            = "./terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_ecr_repository" "app_ecr" {
  name                 = var.ecr_vars.name
  image_tag_mutability = var.ecr_vars.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = var.ecr_vars.scan_on_push
  }
}

data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = var.vpc_vars.name

  cidr = var.vpc_vars.cidr
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = var.vpc_vars.private_subnets
  public_subnets  = var.vpc_vars.public_subnets

  enable_nat_gateway   = var.vpc_vars.enable_nat_gateway
  single_nat_gateway   = var.vpc_vars.single_nat_gateway
  enable_dns_hostnames = var.vpc_vars.enable_dns_hostnames
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_vars.cluster_name
  cluster_version = "1.27"
  cluster_endpoint_public_access = var.eks_vars.cluster_endpoint_public_access

  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.private_subnets

  eks_managed_node_groups = {
    group_one = {
      name = var.eks_vars.node_group_one_name

      instance_types = var.eks_vars.instance_types

      min_size     = var.eks_vars.min_size
      max_size     = var.eks_vars.max_size
      desired_size = var.eks_vars.desired_size
    }
  }
}

output "ecr_repository_name" {
  description = "The name of the created ECR repository"
  value       = aws_ecr_repository.app_ecr.name
}

output "eks_cluster_name" {
  description = "The name of the created EKS cluster"
  value       = module.eks.cluster_name
}
