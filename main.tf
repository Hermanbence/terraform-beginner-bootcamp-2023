terraform {
  cloud {
    organization = "benceakosherman"
    workspaces {
      name = "terra-house-1"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs
resource "random_string" "bucket_name" {
  lower            = true
  upper            = false
  length           = 32
  special          = false
  override_special = ""
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
resource "aws_s3_bucket" "example" {
# Bucket naming rules
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  bucket = "test-${random_string.bucket_name.result}"
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}