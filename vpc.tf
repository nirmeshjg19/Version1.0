resource "aws_vpc" "app-vpc" {
cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  
  tags = {
    Name = "APP-VPC"
  } 
}

resource "aws_subnet" "app-vpc-public" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "${var.public_subnet_cidr}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "app-vpc-publicsubnet"
  }
}

resource "aws_subnet" "app-vpc-protected" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "${var.protected_subnet_cidr}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "app-vpc-protectedsubnet"
  }
}

resource "aws_subnet" "app-vpc-protected-1" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "${var.protected_subnet_cidr_1}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "app-vpc-protectedsubnet-1"
  }
}


resource "aws_subnet" "app-vpc-private" {
  vpc_id                  = aws_vpc.app-vpc.id
  cidr_block              = "${var.private_subnet_cidr}"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "app-vpc-privatesubnet"
  }
}

resource "aws_internet_gateway" "app-vpc-gw" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name = "app-vpc-gw"
  }
}

#public_route_table
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.app-vpc.id
  route {
    cidr_block = "${var.def_cidr}"
    gateway_id = aws_internet_gateway.app-vpc-gw.id
  }
  tags = {
    Name = "main-public-1"
  }
}

#public_route_table association
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.app-vpc-public.id
  route_table_id = aws_route_table.main-public.id
}

