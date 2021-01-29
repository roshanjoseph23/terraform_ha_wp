output "aws_lb_hawordpress_dns_name" {
  value = aws_lb.hawordpress.dns_name
}

output "lb_target_group_hawpmaster" {
  value = aws_lb_target_group.hawpmaster.arn
}

output "lb_target_group_hawpslave" {
  value = aws_lb_target_group.hawpslave.arn
}