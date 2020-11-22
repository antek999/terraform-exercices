resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}


# Subnets
resource "aws_subnet" "app-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_subnet_blocks["app-1"]
  availability_zone = "eu-west-2a"

  tags = {
    Name = "app-1"
    Type = "private"
  }
}


resource "aws_subnet" "app-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_subnet_blocks["app-2"]
  availability_zone = "eu-west-2b"

  tags = {
    Name = "app-2"
    Type = "private"
  }
}

resource "aws_subnet" "web-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_subnet_blocks["web-1"]
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "web-1"
    Type = "public"
  }
}

resource "aws_subnet" "web-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_subnet_blocks["web-2"]
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-2b"

  tags = {
    Name = "web-2"
    Type = "public"
  }
}

resource "aws_subnet" "db-1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_subnet_blocks["db-1"]
  availability_zone = "eu-west-2a"

  tags = {
    Name = "db-1"
    Type = "database"
  }
}

resource "aws_subnet" "db-2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc_subnet_blocks["db-2"]
  availability_zone = "eu-west-2b"

  tags = {
    Name = "db-2"
    Type = "database"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# Route tables
resource "aws_route_table" "internet-access" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "internet-access"
  }
}

resource "aws_route_table_association" "web-1" {
  subnet_id      = aws_subnet.web-1.id
  route_table_id = aws_route_table.internet-access.id
}

resource "aws_route_table_association" "web-2" {
  subnet_id      = aws_subnet.web-2.id
  route_table_id = aws_route_table.internet-access.id
}
