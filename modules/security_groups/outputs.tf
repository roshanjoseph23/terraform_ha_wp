output "security_group_ha_wp_bastion" {
  value = aws_security_group.ha_wp_bastion.id
}

output "security_group_ha_alb" {
  value = aws_security_group.ha_alb.id
}

output "security_group_ha_wp_site" {
  value = aws_security_group.ha_wp_site.id
}

output "security_group_ha_wp_efs" {
  value = aws_security_group.ha_wp_efs.id
}

output "security_group_ha_wp_db" {
  value = aws_security_group.ha_wp_db.id
}