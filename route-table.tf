# Creating public and private route tables

# Public Route Table
resource "aws_route_table" "rt-public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"  # Route all internet-bound traffic
        gateway_id = aws_internet_gateway.main-igw.id  # through the Internet Gateway
    }

    tags = {
        Name = "rt-public"
    }
}

# Private Route Table 1
resource "aws_route_table" "rt-private-1" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"  # Route all internet-bound traffic
        gateway_id = aws_nat_gateway.ngw-1.id  # through NAT Gateway 1
    }

    tags = {
        Name = "rt-private-1"
    }
}

# Private Route Table 2
resource "aws_route_table" "rt-private-2" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"  # Route all internet-bound traffic
        gateway_id = aws_nat_gateway.ngw-2.id  # through NAT Gateway 2
    }

    tags = {
        Name = "rt-private-2"
    }
}

# Creating route table associations

# Associate public subnet 1 with public route table
resource "aws_route_table_association" "pub-1-assoc" {
    subnet_id = aws_subnet.main-pub-sub-1.id
    route_table_id = aws_route_table.rt-public.id
}

# Associate public subnet 2 with public route table
resource "aws_route_table_association" "pub-2-assoc" {
    subnet_id = aws_subnet.main-pub-sub-2.id
    route_table_id = aws_route_table.rt-public.id
}

# Associate private subnet 1 with private route table 1
resource "aws_route_table_association" "pri-1-assoc" {
    subnet_id = aws_subnet.main-pri-sub-1.id
    route_table_id = aws_route_table.rt-private-1.id
}

# Associate private subnet 2 with private route table 2
resource "aws_route_table_association" "pri-2-assoc" {
    subnet_id = aws_subnet.main-pri-sub-2.id
    route_table_id = aws_route_table.rt-private-2.id
}