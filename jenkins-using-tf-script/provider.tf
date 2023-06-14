# provider "aws" {
#   region = "ap-south-1"
# }

terraform {
  #   required_providers {
  #     aws = {
  #       source  = "hashicorp/aws"
  #       version = "~> 3.0"
  #     }
  #   }
  backend "s3" {
    bucket = "shahzad-tf-statefiles"
    key    = "client1/product1/jenkins/terraform.state"
    region = "ap-south-1"
  }
}
