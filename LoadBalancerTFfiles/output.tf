output "ALBTGArn" {
  value = aws_lb_target_group.web.arn
}

output "ALBDNS" {

    value = aws_lb.web.dns_name
}