resource "aws_efs_file_system" "ha_wp_efs" {
  creation_token   = "fs-hawpefs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = "ha_wp_efs"
  }
}

resource "aws_efs_mount_target" "wp_efs" {
  count           = length(local.azone)
  file_system_id  = aws_efs_file_system.ha_wp_efs.id
  subnet_id       = element(local.azone, count.index)
  security_groups = [var.security_group_ha_wp_efs]
}