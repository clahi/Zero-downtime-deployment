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
  #   bucket = "terraform-state-bucket-saldf23"
  #   key = "global/s3/terraform.tfstate"
  #   region = "us-east-1"

  #   # The dynamoDB used to lock the state
  #   dynamodb_table = "terraform-locks"
  #   encrypt = true
  # }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket-saldf23"

  # Prevent accidental deletion of this s3 bucket
  # lifecycle {
  #   prevent_destroy = true
  # }
}

# Enable versioning so you can see the full version of your state files
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption by default 
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Explicitly block all public access to the s3
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.terraform_state.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}


resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}