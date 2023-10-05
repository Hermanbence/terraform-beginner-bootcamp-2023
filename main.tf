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

  tags = {
  UserUuid = var.user_uuid
  }
}