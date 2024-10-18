output "elb_dns_name" {
  value = aws_lb.web_lb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.web_target.arn
  description = "ARN of the target group associated with the ELB"
}