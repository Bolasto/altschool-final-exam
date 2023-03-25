locals {
  cluster_name = var.cluster_name
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19"

  name = local.name
  cidr = local.vpc_cidr


  azs = local.azs
  # azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.6.0/24", "10.0.5.0/24", "10.0.4.0/24"]

  map_public_ip_on_launch = false
  enable_dns_hostnames    = true

  enable_nat_gateway = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/elb"              = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.name}" = "shared"
    "kubernetes.io/role/internal-elb"     = 1
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
data "aws_availability_zones" "available" {}
