resource "aws_lb" "nlb" {
  name                       = "nlb"
  load_balancer_type         = "network"
  subnets                    = aws_subnet.web.*.id
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "nlb-tg" {
  name     = "nlb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb-tg.arn
  }
}