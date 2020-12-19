resource "aws_db_subnet_group" "db-subnets" {
  count      = var.create_database == true ? 1 : 0
  name       = "db-subnet-group"
  subnet_ids = aws_subnet.db.*.id
  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "main-db" {
  count                  = var.create_database == true ? 1 : 0
  allocated_storage      = 30
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.db-instance-class
  name                   = "dbmain"
  username               = var.user
  password               = var.pass
  db_subnet_group_name   = aws_db_subnet_group.db-subnets[count.index].id
  vpc_security_group_ids = [aws_security_group.sg-db[count.index].id]
  skip_final_snapshot    = true
}

resource "aws_security_group" "sg-db" {
  count       = var.create_database == true ? 1 : 0
  name        = "rds-security-group"
  description = "Only MySQL in"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "app"
  }
}
