output "RDS_Endpoint" {
  value = module.rds.ha_wordpress_db_address
}

output "Application_LB_DNS" {
  value = module.alb.aws_lb_hawordpress_dns_name
}

output "EFS_Mount_Target" {
  value = module.efs.aws_efs_file_system_ha_wp_efs
}

output "CDN_Name" {
  value = module.cloudfront.s3cdn_domain_name
}

output "Bastion_DNS" {
  value = module.bastion.aws_instance_bastionserver_public_dns
}

output "Bastion_IP" {
  value = module.bastion.aws_instance_bastionserver_public_ip
}