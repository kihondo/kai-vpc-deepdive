module "aws-backend-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = var.backend_vpc_name

  cidr = var.backend_vpc_cidr

  azs = var.backend_vpc_azs

  private_subnets = var.backend_vpc_private_subnets
  public_subnets  = var.backend_vpc_public_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = var.backend_vpc_enable_nat_gateway
  single_nat_gateway     = var.backend_vpc_single_nat_gateway
  one_nat_gateway_per_az = var.backend_vpc_one_nat_gateway_per_az

  private_subnet_tags = { "Tier" : "backend_vpc_private" }
  public_subnet_tags  = { "Tier" : "backend_vpc_public" }

}