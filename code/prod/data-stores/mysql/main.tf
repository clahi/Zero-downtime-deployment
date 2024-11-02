terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.5"
    }
  }
  required_version = ">= 1.7"

  backend "s3" {
    # The bucket we are going to store our state
    bucket = "terraform-state-bucket-saldf23"
    key = "prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    # The dynamoDB used to lock the state
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "db_instance" {
  identifier_prefix = "prod-db-instance"
  engine = "mysql"
  allocated_storage = 10
  instance_class = "db.t3.micro"
  skip_final_snapshot = true
  db_name = "prod_database"

  username = var.db_username
  password = var.db_password
}
