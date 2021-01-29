terraform {
  backend "s3" {
    bucket  = "<bucket_name>"
    key     = "test/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    profile = "project"
  }
}