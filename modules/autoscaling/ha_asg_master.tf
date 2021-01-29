resource "aws_launch_configuration" "hamaster" {
  name                 = "ha_wp_master"
  image_id             = var.ami
  instance_type        = "t2.micro"
  key_name             = "project"
  security_groups      = [var.security_group_ha_wp_site]
  iam_instance_profile = var.aws_iam_instance_profile_s3_role_name
  user_data            = templatefile("./modules/autoscaling/s3sfs.sh", { efspoint = var.aws_efs_file_system_ha_wp_efs })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "hamasterasg" {
  name                 = "ha_wp_master_asg"
  launch_configuration = aws_launch_configuration.hamaster.name
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [var.ha_wp_pub1_id, var.ha_wp_pub2_id, var.ha_wp_pub3_id]
  target_group_arns    = [var.lb_target_group_hawpmaster]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "WordpressMaster"
    propagate_at_launch = true
  }
}