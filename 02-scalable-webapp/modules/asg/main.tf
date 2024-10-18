resource "aws_launch_template" "web_template" {
  name_prefix   = "web-launch-template"
  instance_type = var.instance_type
  image_id      = var.ami_id
  user_data     = base64encode(file(var.user_data))

  network_interfaces {
    subnet_id   = var.subnet_id
    associate_public_ip_address = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = [var.subnet_id]
  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]
}