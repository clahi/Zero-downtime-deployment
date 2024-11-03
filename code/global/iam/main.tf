terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.5"
    }
  }
  required_version = ">= 1.7"

  # backend "s3" {
  #   # The bucket we are going to store our state
  #   bucket = "terraform-state-bucket-saldf234"
  #   key = "global/iam/terraform.tfstate"
  #   region = "us-east-1"

  #   # The dynamoDB used to lock the state
  #   dynamodb_table = "terraform-locks"
  #   encrypt = true
  # }
}

provider "aws" {
  region = "us-east-1"
}

module "user" {
  source = "../../modules/landing-zone/iam-user"
  
  for_each = toset(var.user_names)
  user_name = each.value
}

# resource "aws_iam_user" "user" {
#   for_each = toset(var.user_names)
#   name = each.value
# }

