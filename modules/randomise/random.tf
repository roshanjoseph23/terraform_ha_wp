resource "random_shuffle" "ha_sub_pub" {
  input        = [var.ha_wp_pub1_id, var.ha_wp_pub2_id, var.ha_wp_pub3_id]
  result_count = 1
}

resource "random_shuffle" "ha_az" {
  input        = [var.priv_az1, var.priv_az2, var.priv_az3]
  result_count = 1
}

