
resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Terraform'sVPC"
    Environment = var.Environment
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc1.id

  count = length(var.public_subnets)

  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone = "${var.region}${var.azs[count.index]}"
  tags = {
    Name = "Subnet-${count.index}"
  }
}



resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "Terraform'sIGW"
  }
}

resource "aws_route_table" "web" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
    depends_on = [aws_vpc.vpc1,aws_internet_gateway.gw]

  tags = {
    Name = "PublicRouteTable"
    Environment = var.Environment
  }
}
