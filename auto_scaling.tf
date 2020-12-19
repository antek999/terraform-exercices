resource "aws_launch_template" "aws-launch-template" {
  name_prefix            = "aws-launch-template"
  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg-ssh-pub.id]
  user_data              = base64encode(templatefile("${path.module}/helpers/install_nginx.sh", {}))
  key_name               = "ssh"
}

resource "aws_autoscaling_policy" "asg_policy" {
  name                   = "auto scaling policy"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 3.0
  }
  estimated_instance_warmup = 300
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity          = 1
  max_size                  = 5
  min_size                  = 1
  vpc_zone_identifier       = aws_subnet.web.*.id
  target_group_arns         = [aws_lb_target_group.nlb-tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.aws-launch-template.id
    version = "$Latest"
  }
}


#resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
# alarm_name          = "cpu_utilization_auto_scaling"
#comparison_operator = "GreaterThanOrEqualToThreshold"
#evaluation_periods  = "2"
#metric_name         = "CPUUtilization"
#namespace           = "AWS/EC2"
#period              = "120"
#statistic           = "Average"
#threshold           = "3"

#dimensions = {
#  AutoScalingGroupName = aws_autoscaling_group.asg.name
#}

#alarm_description = "This metric monitors ec2 cpu utilization"
#alarm_actions     = [aws_autoscaling_policy.asg_policy.arn]
#}