#natgateway
resource "aws_eip" "nat" {
vpc=true  
}

resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.app-vpc-public.id
    depends_on= [aws_internet_gateway.app-vpc-gw] 
    tags = {
      Name = "Nat_gat1"
    }
}

#route_table_protected
resource "aws_route_table" "main-protected" {
  vpc_id = aws_vpc.app-vpc.id
  route {
    cidr_block     = "${var.def_cidr}"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-protected-1"
  }
}

#route_association_protected
resource "aws_route_table_association" "main-protected-1-a" {
  subnet_id      = aws_subnet.app-vpc-protected.id
  route_table_id = aws_route_table.main-protected.id
}
resource "aws_route_table_association" "main-protected-2-b" {
  subnet_id      = aws_subnet.app-vpc-protected-1.id
  route_table_id = aws_route_table.main-protected.id
}