terraform { required_providers { aws = { source = "hashicorp/aws" version = "~> 5.0" } } }
provider "aws" { region = var.region }

resource "aws_s3_bucket_logging" "this" {
  bucket        = var.target_bucket
  target_bucket = var.log_bucket
  target_prefix = var.log_prefix
}
