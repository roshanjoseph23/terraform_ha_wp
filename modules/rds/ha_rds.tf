resource "aws_db_subnet_group" "private" {
  name       = "main"
  subnet_ids = [var.ha_wp_priv1_id, var.ha_wp_priv2_id, var.ha_wp_priv3_id]

  tags = {
    Name = "My DB subnet group"
  }
}
resource "aws_db_instance" "ha_wordpress_db" {
  identifier              = "hawordpressdb"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.21"
  instance_class          = "db.t2.micro"
  name                    = "wordpress"
  username                = "root"
  password                = "admin123"
  parameter_group_name    = "default.mysql8.0"
  port                    = 3306
  vpc_security_group_ids  = [var.security_group_ha_wp_db]
  backup_retention_period = 1
  availability_zone       = var.random_shuffle_ha_az
  db_subnet_group_name    = aws_db_subnet_group.private.name
  skip_final_snapshot     = true
}