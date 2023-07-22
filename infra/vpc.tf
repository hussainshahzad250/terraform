# 1: Create a VPC
resource "aws_vpc" "myvpc" {
  /* count                            = var.create_vpc ? 1 : 0 */
  cidr_block                       = var.vpc_cidr
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = var.enable_ipv6
  tags = {
    "Name" = format("%s-%s-%s", var.environment, var.clientName, var.product)
  }
}

