
resource "aws_instance" "app-2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = "eu-west-2b"
  subnet_id              = aws_subnet.app-2.id
  vpc_security_group_ids = [aws_security_group.sg-ssh-private.id]
  key_name               = "internal"
  tags = {
    Name = "app-2"
  }
}


