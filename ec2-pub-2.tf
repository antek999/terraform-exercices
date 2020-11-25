
resource "aws_instance" "web-2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = "eu-west-2b"
  subnet_id              = aws_subnet.web-2.id
  vpc_security_group_ids = [aws_security_group.sg-ssh-pub.id]
  key_name               = "ssh"
  tags = {
    Name = "web-2"
  }
}