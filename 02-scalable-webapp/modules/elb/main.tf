resource "aws_lb" "web_lb" {
  name               = "web-load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids

  security_groups = [var.elb_security_group]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_target.arn
  }
}

resource "aws_lb_target_group" "web_target" {
  name     = "web-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}