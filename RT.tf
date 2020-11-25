resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id
  count  = 2

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw[count.index].id
  }

  tags = {
    Name = "private-rt-${count.index}"
  }
}

resource "aws_route_table_association" "web-1" {
  subnet_id      = aws_subnet.web-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "web-2" {
  subnet_id      = aws_subnet.web-2.id
  route_table_id = aws_route_table.public-rt.id
}


resource "aws_route_table_association" "app-1" {
  subnet_id      = aws_subnet.app-1.id
  route_table_id = aws_route_table.private-rt[0].id
}

resource "aws_route_table_association" "app-2" {
  subnet_id      = aws_subnet.app-2.id
  route_table_id = aws_route_table.private-rt[1].id
}

resource "aws_route_table_association" "db-1" {
  subnet_id      = aws_subnet.db-1.id
  route_table_id = aws_route_table.private-rt[0].id
}

resource "aws_route_table_association" "db-2" {
  subnet_id      = aws_subnet.db-2.id
  route_table_id = aws_route_table.private-rt[1].id
}