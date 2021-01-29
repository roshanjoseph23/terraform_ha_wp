variable "security_group_ha_wp_efs" {}
variable "ha_wp_pub1_id" {}
variable "ha_wp_pub2_id" {}
variable "ha_wp_pub3_id" {}
locals {
  azone = [var.ha_wp_pub1_id, var.ha_wp_pub2_id, var.ha_wp_pub3_id]
}