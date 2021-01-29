resource "aws_launch_configuration" "haslave" {
  name            = "ha_wp_slave"
  image_id        = var.ami
  instance_type   = "t2.micro"
  key_name        = "project"
  security_groups = [var.security_group_ha_wp_site]
  user_data       = templatefile("./modules/autoscaling/efs.sh", { efspoint = var.aws_efs_file_system_ha_wp_efs })
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "haslaveasg" {
  name                 = "ha_wp_slave_asg"
  launch_configuration = aws_launch_configuration.haslave.name
  min_size             = var.min
  max_size             = var.max
  desired_capacity     = var.des
  vpc_zone_identifier  = [var.ha_wp_pub1_id, var.ha_wp_pub2_id, var.ha_wp_pub3_id]
  target_group_arns    = [var.lb_target_group_hawpslave]
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "WordpressSlave"
    propagate_at_launch = true
  }
}