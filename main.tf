terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = "us-east-1"
  profile = "project"
}

resource "aws_vpc" "hawp" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "ha_wp"
  }
}

module "alb" {
  source                = "./modules/alb"
  vpc_id                = aws_vpc.hawp.id
  ha_wp_pub1_id         = module.subnets.ha_wp_pub1_id
  ha_wp_pub2_id         = module.subnets.ha_wp_pub2_id
  ha_wp_pub3_id         = module.subnets.ha_wp_pub3_id
  security_group_ha_alb = module.sg.security_group_ha_alb
}

module "autoscaling" {
  source                                = "./modules/autoscaling"
  security_group_ha_wp_site             = module.sg.security_group_ha_wp_site
  aws_iam_instance_profile_s3_role_name = module.iam.aws_iam_instance_profile_s3_role_name
  aws_efs_file_system_ha_wp_efs         = module.efs.aws_efs_file_system_ha_wp_efs
  ami                                   = var.ami
  min                                   = var.min
  max                                   = var.max
  des                                   = var.des
  ha_wp_pub1_id                         = module.subnets.ha_wp_pub1_id
  ha_wp_pub2_id                         = module.subnets.ha_wp_pub2_id
  ha_wp_pub3_id                         = module.subnets.ha_wp_pub3_id
  lb_target_group_hawpmaster            = module.alb.lb_target_group_hawpmaster
  lb_target_group_hawpslave             = module.alb.lb_target_group_hawpslave
}

module "bastion" {
  source                       = "./modules/Bastion"
  security_group_ha_wp_bastion = module.sg.security_group_ha_wp_bastion
  random_shuffle_ha_sub_pub    = module.random.random_shuffle_ha_sub_pub
  ami                          = var.ami
}

module "cloudfront" {
  source                                 = "./modules/cloudfront"
  aws_s3_bucket_ha_s3_bucket_domain_name = module.s3.aws_s3_bucket_ha_s3_bucket_domain_name
  s3origin                               = var.s3origin
}

module "efs" {
  source                   = "./modules/efs"
  ha_wp_pub1_id            = module.subnets.ha_wp_pub1_id
  ha_wp_pub2_id            = module.subnets.ha_wp_pub2_id
  ha_wp_pub3_id            = module.subnets.ha_wp_pub3_id
  security_group_ha_wp_efs = module.sg.security_group_ha_wp_efs
}

module "iam" {
  source = "./modules/iam"
}

module "igw" {
  source = "./modules/internet_gateway"
  vpc_id = aws_vpc.hawp.id
}

module "rds" {
  source                  = "./modules/rds"
  ha_wp_priv1_id          = module.subnets.ha_wp_priv1_id
  ha_wp_priv2_id          = module.subnets.ha_wp_priv2_id
  ha_wp_priv3_id          = module.subnets.ha_wp_priv3_id
  security_group_ha_wp_db = module.sg.security_group_ha_wp_db
  random_shuffle_ha_az    = module.random.random_shuffle_ha_az
}

module "rtb" {
  source                  = "./modules/route_tables"
  vpc_id                  = aws_vpc.hawp.id
  ha_wp_priv1_id          = module.subnets.ha_wp_priv1_id
  ha_wp_priv2_id          = module.subnets.ha_wp_priv2_id
  ha_wp_priv3_id          = module.subnets.ha_wp_priv3_id
  ha_wp_pub1_id           = module.subnets.ha_wp_pub1_id
  ha_wp_pub2_id           = module.subnets.ha_wp_pub2_id
  ha_wp_pub3_id           = module.subnets.ha_wp_pub3_id
  aws_internet_gateway_gw = module.igw.aws_internet_gateway_gw
}

module "s3" {
  source = "./modules/s3"
}

module "sg" {
  source = "./modules/security_groups"
  vpc_id = aws_vpc.hawp.id
}

module "subnets" {
  source   = "./modules/subnets"
  vpc_id   = aws_vpc.hawp.id
  priv_az1 = var.priv_az1
  priv_az2 = var.priv_az2
  priv_az3 = var.priv_az3
  pub_az1  = var.pub_az1
  pub_az2  = var.pub_az2
  pub_az3  = var.pub_az3
}

module "random" {
  source        = "./modules/randomise"
  ha_wp_pub1_id = module.subnets.ha_wp_pub1_id
  ha_wp_pub2_id = module.subnets.ha_wp_pub2_id
  ha_wp_pub3_id = module.subnets.ha_wp_pub3_id
  priv_az1      = var.priv_az1
  priv_az2      = var.priv_az2
  priv_az3      = var.priv_az3
}
