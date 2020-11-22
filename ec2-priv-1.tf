
resource "aws_instance" "app-1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = "eu-west-2a"
  subnet_id              = aws_subnet.app-1.id
  vpc_security_group_ids = [aws_security_group.sg-ssh-private.id]
  key_name = "internal"
  tags = {
    Name = "app-1"
  }
}


resource "aws_security_group" "sg-ssh-private" {
  name        = "allow_ssh-from-private"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "ssh"
    from_port    = 22
    to_port     = 22
    protocol     = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block ]
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
