# creating internet gateway and attaching it to vpc
resource "aws_internet_gateway" "main-igw" {
    # The vpc id to create in
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "main-igw"
    }
  
}