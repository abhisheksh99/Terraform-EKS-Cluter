# creating nat gateways in 2 availability zones
resource "aws_nat_gateway" "ngw-1" {
    # the allocation id of the elastic ip address for the gateway
    allocation_id = aws_eip.main-nat-1.id
    # the subnetid of the subnet in which to place the gateway
    subnet_id = aws_subnet.main-pub-sub-1.id

    tags = {
      Name = "NAT_1"
    }

  
}

resource "aws_nat_gateway" "ngw-2" {
    # the allocation id of the elastic ip address for the gateway
    allocation_id = aws_eip.main-nat-2.id
    # the subnetid of the subnet in which to place the gateway
    subnet_id = aws_subnet.main-pub-sub-2.id

    tags = {
      Name = "NAT_2"
    }

  
}