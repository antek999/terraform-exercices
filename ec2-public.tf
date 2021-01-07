resource "aws_instance" "ec2-web" {
  count                  = 2
  ami                    = var.ami
  instance_type          = var.instance_type
  availability_zone      = var.azs[count.index % length(var.azs)]
  subnet_id              = aws_subnet.web[count.index].id
  vpc_security_group_ids = [aws_security_group.sg-ssh-pub.id]
  key_name               = "ssh"
  user_data              = base64encode(templatefile("${path.module}/helpers/install_nginx.sh", {}))

  tags = {
    Name = "ec2-web-${count.index}"
  }
}