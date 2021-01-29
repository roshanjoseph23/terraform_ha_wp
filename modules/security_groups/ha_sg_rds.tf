resource "aws_security_group" "ha_wp_db" {
  name   = "ha_wp_db"
  vpc_id = var.vpc_id

  ingress {
    description     = "DB from Website"
    from_port       = 3306
    to_port         = 3306
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
    Name = "ha_wp_db"
  }
}