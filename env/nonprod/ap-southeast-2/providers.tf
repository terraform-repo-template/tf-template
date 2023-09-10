provider "aws" {
  region              = local.region
  allowed_account_ids = [module.constants.aws_accounts["nonprod"].id]

  assume_role {
    role_arn = "arn:aws:iam::${module.constants.aws_accounts["nonprod"].id}:role/build-iac"
  }
}

terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      version = "~> 5.16.1"
    }
  }

  backend "s3" {
    bucket = "my-terraform-statefile-bucket"
    key    = "tf-template/env/nonprod/ap-southeast-2"
    region = "ap-southeast-2"

    role_arn = "arn:aws:iam::${aws-account-id-where-statefile-is-stored}:role/build-statefile-s3"
  }
}