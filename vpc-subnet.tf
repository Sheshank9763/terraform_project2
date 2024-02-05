resource "aws_vpc" "vpc1" {
    cidr_block = "171.0.0.0/16"
    tags = {
      Name = "vpc1"
    }
}
resource "aws_subnet" "public1" {
    cidr_block = "171.0.0.0/24"
    vpc_id = aws_vpc.vpc1.id
    availability_zone = "us-west-2a"
    tags = {
      Name = "public-subnet1"
    }
}
resource "aws_subnet" "public2" {
    cidr_block = "171.0.4.0/24"
    vpc_id = aws_vpc.vpc1.id
    availability_zone = "us-west-2b"
    tags = {
      Name = "public-subnet2"
    }
}
resource "aws_subnet" "private1" {
    cidr_block = "171.0.5.0/24"
    vpc_id = aws_vpc.vpc1.id
    availability_zone = "us-west-2a"
    tags = {
      Name = "private-subnet1"
    }
}
resource "aws_subnet" "private2" {
    cidr_block = "171.0.6.0/24"
    vpc_id = aws_vpc.vpc1.id
    availability_zone = "us-west-2b"
    tags = {
      Name = "private-subnet2"
    }
}
resource "aws_internet_gateway" "IGW1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
      Name = "IGW1"
    }
}
resource "aws_route_table" "route_public_1" {
    vpc_id = aws_vpc.vpc1.id 
    tags = {
      Name = "route_public_1"
    }
}
resource "aws_route_table" "route_public_2" {
    vpc_id = aws_vpc.vpc1.id 
    tags = {
      Name = "route_public_2"
    }
}
resource "aws_route_table" "route_private_1" {
    vpc_id = aws_vpc.vpc1.id 
    tags = {
      Name = "route_private_1"
    }
}
resource "aws_route_table" "route_private_2" {
    vpc_id = aws_vpc.vpc1.id 
    tags = {
      Name = "route_private_2"
    }
}
resource "aws_route_table_association" "route_public_1" {
    route_table_id = aws_route_table.route_public_1.id
    subnet_id = aws_subnet.public1.id
}
resource "aws_route_table_association" "route_public_2" {
    route_table_id = aws_route_table.route_public_2.id
    subnet_id = aws_subnet.public2.id
}
resource "aws_route_table_association" "route_private_1" {
    route_table_id = aws_route_table.route_private_1.id
    subnet_id = aws_subnet.private1.id
}
resource "aws_route_table_association" "route_private_2" {
    route_table_id = aws_route_table.route_private_2.id
    subnet_id = aws_subnet.private2.id
}
resource "aws_route" "rt1" {
  route_table_id = aws_route_table.route_public_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW1.id
}
resource "aws_route" "rt2" {
  route_table_id = aws_route_table.route_public_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW1.id
}