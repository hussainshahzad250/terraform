# configured aws provider with proper credentials
terraform {
  # required_providers {
  #   aws = {
  #     source  = "hashicorp/aws"
  #     version = "~> 3.0"
  #   }
  # }
  backend "s3" {
    bucket = "shahzad-tf-statefiles"
    key    = "SHAHZAD/vpc-ec2-sg/terraform.state"
    region = "ap-south-1"
  }
}