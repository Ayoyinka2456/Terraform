# VPC
resource "aws_vpc" "food-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "food vpc"
  }
}
# PUBLIC SUBNET
resource "aws_subnet" "food-pub-sn" {
  vpc_id     = aws_vpc.food-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "food public subnet"
  }
}
# PRIVATE SUBNET
resource "aws_subnet" "food-pvt-sn" {
  vpc_id     = aws_vpc.food-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "food private subnet"
  }
}
# INTERNET GATEWAY
resource "aws_internet_gateway" "food-igw" {
  vpc_id = aws_vpc.food-vpc.id
  tags = {
    Name = "food igw"
  }
}
# PUBLIC RT
resource "aws_route_table" "food-pub-rt" {
  vpc_id = aws_vpc.food-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.food-igw.id
  }
  tags = {
    Name = "food public rt"
  }
}
# PRIVATE RT
resource "aws_route_table" "food-pvt-rt" {
 vpc_id = aws_vpc.food-vpc.id
 tags = {
    Name = "food private rt"
  }
}
# SUBNET - ROUTE TABLE ASSOCIATION -PUBLIC
resource "aws_route_table_association" "food-pub-asc" {
  subnet_id      = aws_subnet.food-pub-sn.id
  route_table_id = aws_route_table.food-pub-rt.id
}
# SUBNET - ROUTE TABLE ASSOCIATION -PRIVATE
resource "aws_route_table_association" "food-pvt-asc" {
  subnet_id      = aws_subnet.food-pvt-sn.id
  route_table_id = aws_route_table.food-pvt-rt.id
}
# Elastic IP for NAT Gateway
resource "aws_eip" "nat1" {
  tags = {
    Name = "eip_NAT"
  }
  depends_on = [aws_internet_gateway.food-igw]
}

resource "aws_nat_gateway" "pub-nat" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.food-pub-sn.id
  tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.food-igw]
}
