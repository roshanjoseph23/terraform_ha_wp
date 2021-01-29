resource "aws_route_table" "ha_rtb_priv" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ha_rtb_priv"
  }
}

resource "aws_route_table_association" "rtb_sub_priv" {
  subnet_id      = var.ha_wp_priv1_id
  route_table_id = aws_route_table.ha_rtb_priv.id
}

resource "aws_route_table_association" "rtb_sub_priv2" {
  subnet_id      = var.ha_wp_priv2_id
  route_table_id = aws_route_table.ha_rtb_priv.id
}

resource "aws_route_table_association" "rtb_sub_priv3" {
  subnet_id      = var.ha_wp_priv1_id
  route_table_id = aws_route_table.ha_rtb_priv.id
}