resource "aws_security_group" "ha_wp_efs" {
  name   = "ha_wp_efs"
  vpc_id = var.vpc_id

  ingress {
    description     = "EFS from Website"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ha_wp_site.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ha_wp_efs"
  }
}