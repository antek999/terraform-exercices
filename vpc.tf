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

# Elastic IP

resource "aws_eip" "nat-eip-with-count" {
  vpc   = true
  count = 2
  tags = {
    "Name" = "basic-${count.index}"
  }
}

# Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
  count         = 2
  allocation_id = aws_eip.nat-eip-with-count["${count.index}"].id
  subnet_id     = aws_subnet.web-1.id

  tags = {
    "Name" = "Nat-Gateway-${count.index}"
  }
}