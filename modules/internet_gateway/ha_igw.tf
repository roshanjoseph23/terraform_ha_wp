resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ha_wp_igw"
  }
}