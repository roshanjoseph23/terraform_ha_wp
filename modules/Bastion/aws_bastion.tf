resource "aws_instance" "bastionserver" {


  ami                         = var.ami
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_ha_wp_bastion]
  key_name                    = "project"
  subnet_id                   = var.random_shuffle_ha_sub_pub
  root_block_device {
    volume_size = "8"
  }
  tags = {
    Name = "Bastion"
  }
}
