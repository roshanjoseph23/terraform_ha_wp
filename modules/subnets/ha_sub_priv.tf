resource "aws_subnet" "ha_wp_priv1" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.16.128.0/19"
  availability_zone = var.priv_az1
  tags = {
    Name = "ha_wp_priv1"
  }
}


resource "aws_subnet" "ha_wp_priv2" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.16.160.0/19"
  availability_zone = var.priv_az2
  tags = {
    Name = "ha_wp_priv2"
  }
}

resource "aws_subnet" "ha_wp_priv3" {
  vpc_id            = var.vpc_id
  cidr_block        = "172.16.192.0/19"
  availability_zone = var.priv_az3
  tags = {
    Name = "ha_wp_priv3"
  }
}