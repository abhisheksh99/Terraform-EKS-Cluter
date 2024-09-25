# creating elasctic ips for nat gateway
resource "aws_eip" "main-nat-1" {
    #EIP may require IGW to exist prior to association
    # use depends_on to set an explicit dependency on the iGW
    depends_on = [ aws_internet_gateway.main-igw ]

    tags ={
        Name = "eip_1"
    }

  
}

resource "aws_eip" "main-nat-2" {
    #EIP may require IGW to exist prior to association
    # use depends_on to set an explicit dependency on the iGW
    depends_on = [ aws_internet_gateway.main-igw ]
     tags ={
        Name = "eip_2"
    }

    
  
}