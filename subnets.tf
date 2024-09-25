# Creating public and private subnets

# Public Subnet 1
resource "aws_subnet" "main-pub-sub-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.main_pub_sub_1_cidr
    availability_zone = var.main_avail_zone_1
    map_public_ip_on_launch = true  # Enables auto-assign public IP

    tags = {
      Name = "main-pub-sub-1"
      # Indicates subnet is used by EKS cluster
      "kubernetes.io/cluster/eks" = "shared"
      # Marks subnet for use with Elastic Load Balancers
      "kubernetes.io/role/elb" = 1
    }
}

# Public Subnet 2
resource "aws_subnet" "main-pub-sub-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.main_pub_sub_2_cidr
    availability_zone = var.main_avail_zone_2
    map_public_ip_on_launch = true  # Enables auto-assign public IP

    tags = {
      Name = "main-pub-sub-2"
      # Indicates subnet is used by EKS cluster
      "kubernetes.io/cluster/eks" = "shared"
      # Marks subnet for use with Elastic Load Balancers
      "kubernetes.io/role/elb" = 1
    }
}

# Private Subnet 1
resource "aws_subnet" "main-pri-sub-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.main_pri_sub_1_cidr
    availability_zone = var.main_avail_zone_1
    # Note: map_public_ip_on_launch is not set for private subnets

    tags = {
      Name = "main-pri-sub-1"
      # Indicates subnet is used by EKS cluster
      "kubernetes.io/cluster/eks" = "shared"
      # Marks subnet for use with internal Elastic Load Balancers
      "kubernetes.io/role/internal-elb" = 1
    }
}

# Private Subnet 2
resource "aws_subnet" "main-pri-sub-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.main_pri_sub_2_cidr
    availability_zone = var.main_avail_zone_2
    # Note: map_public_ip_on_launch is not set for private subnets

    tags = {
      Name = "main-pri-sub-2"
      # Indicates subnet is used by EKS cluster
      "kubernetes.io/cluster/eks" = "shared"
      # Marks subnet for use with internal Elastic Load Balancers
      "kubernetes.io/role/internal-elb" = 1
    }
}