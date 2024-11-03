terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.5"
    }
  }
  required_version = ">= 1.7"

  # backend "s3" {
  #   # The bucket we are going to store our state
  #   bucket = "terraform-state-bucket-saldf234"
  #   key = "prod/services/webserver-cluster/terraform.tfstate"
  #   region = "us-east-1"

  #   # The dynamoDB used to lock the state
  #   dynamodb_table = "terraform-locks"
  #   encrypt = true
  # }
}

provider "aws" {
  region = "us-east-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  # The input variables to be used in the module.
  cluster_name = "webservers-prod"
  db_remote_state_bucket = "terraform-state-bucket-saldf234"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t3.micro"
  min_size = 2
  max_size = 10

  custom_tags = {
    Owner = "terraform-owner"
    ManagedBy = "terraform"
  }

  enable_autoscaling = true
}