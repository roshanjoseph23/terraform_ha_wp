resource "aws_subnet" "ha_wp_pub1" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.16.32.0/19"
  availability_zone       = var.pub_az1
  map_public_ip_on_launch = true
  tags = {
    Name = "ha_wp_pub1"
  }
}

resource "aws_subnet" "ha_wp_pub2" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.16.64.0/19"
  availability_zone       = var.pub_az2
  map_public_ip_on_launch = true
  tags = {
    Name = "ha_wp_pub2"
  }
}

resource "aws_subnet" "ha_wp_pub3" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.16.96.0/19"
  availability_zone       = var.pub_az3
  map_public_ip_on_launch = true
  tags = {
    Name = "ha_wp_pub3"
  }
}