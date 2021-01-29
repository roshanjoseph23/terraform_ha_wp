resource "aws_security_group" "ha_wp_site" {
  name   = "ha_wp_site"
  vpc_id = var.vpc_id

  ingress {
    description     = "TLS from VPC"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ha_alb.id]
  }

  ingress {
    description     = "HTTP from VPC"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ha_alb.id]
  }

  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.ha_wp_bastion.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ha_wp_site"
  }
}