
data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_vpc" "vpc1" {
  cidr_block       = var.cidr_block
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
  availability_zone = data.aws_availability_zones.available.names[count.index]
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
resource "aws_route_table_association" "a" {

  count = length(var.public_subnets)
  subnet_id      = element(aws_subnet.subnet[*].id,count.index)
  route_table_id = aws_route_table.web.id
}