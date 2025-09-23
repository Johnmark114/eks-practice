terraform {
  backend "s3" {
    bucket = "innovatemart-state-lock-812835203419"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  #   required_providers {
  #   aws = {
  #     source = "hashicorp/aws"
  #     version = "6.14.0"
  #   }
  # }
}
