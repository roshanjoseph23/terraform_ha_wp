resource "aws_route_table" "ha_rtb_pub" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.aws_internet_gateway_gw
  }
  tags = {
    Name = "ha_rtb_pub"
  }
}

resource "aws_route_table_association" "rtb_sub_pub" {
  subnet_id      = var.ha_wp_pub1_id
  route_table_id = aws_route_table.ha_rtb_pub.id
}

resource "aws_route_table_association" "rtb_sub_pub2" {
  subnet_id      = var.ha_wp_pub2_id
  route_table_id = aws_route_table.ha_rtb_pub.id
}

resource "aws_route_table_association" "rtb_sub_pub3" {
  subnet_id      = var.ha_wp_pub3_id
  route_table_id = aws_route_table.ha_rtb_pub.id
}


