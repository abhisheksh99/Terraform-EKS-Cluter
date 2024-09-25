# creating vpc
resource "aws_vpc" "main" {
  # The CIDR block for VPC
  cidr_block = var.vpc_cidr_block
  # Makes your instance shared on host
  instance_tenancy = "default"
  # Required by eks. Enable dns support for vpc
  enable_dns_support = true
  # Required by eks. Enable hostname support for vpc
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }

}



