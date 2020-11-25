
resource "aws_instance" "web-1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = "eu-west-2a"
  subnet_id              = aws_subnet.web-1.id
  vpc_security_group_ids = [aws_security_group.sg-ssh-pub.id]
  key_name               = "ssh"
  tags = {
    Name = "web-1"
  }
}


resource "aws_security_group" "sg-ssh-pub" {
  name        = "allow_ssh-from-public"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = concat([aws_vpc.main.cidr_block], var.home_ips)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web"
  }
}
