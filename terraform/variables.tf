variable "aws_region" {
  type = string
  default = "eu-central-1"
}

variable "helm_ecr_vars" {
  type = object({
    name                  : string
    image_tag_mutability  : string
    scan_on_push          : bool
  })
  default = {
    name                  = "helm_app_ecr"
    image_tag_mutability  = "MUTABLE"
    scan_on_push          = false
  }
}

variable "image_ecr_vars" {
  type = object({
    name                  : string
    image_tag_mutability  : string
    scan_on_push          : bool
  })
  default = {
    name                  = "image_app_ecr"
    image_tag_mutability  = "MUTABLE"
    scan_on_push          = false
  }
}

variable "vpc_vars" {
  type = object({
    name                 : string
    cidr                 : string
    private_subnets      : list(string)
    public_subnets       : list(string)
    enable_nat_gateway   : bool
    single_nat_gateway   : bool
    enable_dns_hostnames : bool
  })
  default = {
    name                 = "app-vpc"
    cidr                 = "10.0.0.0/16"
    private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
    enable_nat_gateway   = true
    single_nat_gateway   = true
    enable_dns_hostnames = true
  }
}

variable "eks_vars" {
  type = object({
    cluster_name                    : string
    cluster_endpoint_public_access  : bool
    node_group_one_name             : string
    instance_types                  : list(string)
    min_size                        : number
    max_size                        : number
    desired_size                    : number
  })
  default = {
    cluster_name                    = "app-eks-cluster"
    cluster_endpoint_public_access  = "true"
    node_group_one_name             = "node-group-1"
    instance_types                  = ["t2.medium"]
    min_size                        = 0
    max_size                        = 2
    desired_size                    = 1
  }
}