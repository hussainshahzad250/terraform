# VPC Creation
resource "aws_vpc" "vpc" {
  count                            = var.create_vpc ? 1 : 0
  cidr_block                       = var.vpc_cidr
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  tags = {
    "Environment" = var.environment
    "ClientName"  = var.clientName
    "Name"        = format("%s-%s-%s", var.environment, var.clientName, var.product)
  }
}

